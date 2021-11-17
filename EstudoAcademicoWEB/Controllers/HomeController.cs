using EstudoAcademicoWEB.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;

namespace EstudoAcademicoWEB.Controllers
{
    public class HomeController : Controller
    {
        private HotelDBContext db = new HotelDBContext();
        // GET: Home

        public ActionResult Index()
        {
           
                return View();
            
        }
        public ActionResult Create([Bind(Include = "ID_FALE_CONOSCO,EMAIL,MENSAGEM,NOME_DO_REMETENTE")] FaleConosco faleConosco)
        {
            if (ModelState.IsValid)
            {
                db.FaleConosco.Add(faleConosco);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(faleConosco);
        }

        [HttpPost]
        public ActionResult EnviaEmail()
        {
            string nomeDestinatario = Request.Form["Name"];
            string emailDestinatario = Request.Form["Email"];
            string assuntoDestinatario = Request.Form["Assunto"];
            string comentarioDestinatario = Request.Form["Comentário"];
            SendMail(nomeDestinatario, emailDestinatario, assuntoDestinatario, comentarioDestinatario);

            return RedirectToAction("Create");

        }

        public bool SendMail(string name, string email, string subject, string comment)
        {
            try
            {
                // Estancia da Classe de Mensagem
                MailMessage _mailMessage = new MailMessage();
                // Remetente
                _mailMessage.From = new MailAddress("hotelwebunip@gmail.com");

                // Destinatario seta no metodo abaixo

                //Contrói o MailMessage
                _mailMessage.CC.Add(email);
                _mailMessage.CC.Add("hotelwebunip@gmail.com");
                _mailMessage.Subject = $"{subject}";
                _mailMessage.IsBodyHtml = true;
                _mailMessage.Body = htmlEmail(name, subject, comment);

                //CONFIGURAÇÃO COM PORTA
                SmtpClient _smtpClient = new SmtpClient("smtp.gmail.com", Convert.ToInt32("587"));

                //CONFIGURAÇÃO SEM PORTA
                // SmtpClient _smtpClient = new SmtpClient(UtilRsource.ConfigSmtp);

                // Credencial para envio por SMTP Seguro (Quando o servidor exige autenticação)
                _smtpClient.UseDefaultCredentials = false;
                _smtpClient.Credentials = new NetworkCredential("hotelwebunip@gmail.com", "hotelwebunip2021");

                _smtpClient.EnableSsl = true;

                _smtpClient.Send(_mailMessage);

                return true;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private string htmlEmail(string name, string subject, string comment)
        {
            string htmlEmail = $"Olá, <b>{name}.</b><p>Recebemos seu pedido de ajuda com o assunto: {subject} e com a seguinte mensagem: </p>" +
                $"<p>{comment}</p>" + 
                "<p>Entraremos em contato com você o mais rápido possível!</p>";


            return htmlEmail;
        }


      
    }
}