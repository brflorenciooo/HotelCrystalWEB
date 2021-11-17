using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using EstudoAcademicoWEB.Models;

namespace EstudoAcademicoWEB.Controllers
{
    public class FaleConoscoController : Controller
    {
        private HotelDBContext db = new HotelDBContext();

        // GET: FaleConosco
        public ActionResult Index()
        {
            return View(db.FaleConosco.ToList());
        }

        // GET: FaleConosco/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            FaleConosco faleConosco = db.FaleConosco.Find(id);
            if (faleConosco == null)
            {
                return HttpNotFound();
            }
            return View(faleConosco);
        }

        // GET: FaleConosco/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: FaleConosco/Create
        // Para se proteger de mais ataques, habilite as propriedades específicas às quais você quer se associar. Para 
        // obter mais detalhes, veja https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
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

        // GET: FaleConosco/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            FaleConosco faleConosco = db.FaleConosco.Find(id);
            if (faleConosco == null)
            {
                return HttpNotFound();
            }
            return View(faleConosco);
        }

        // POST: FaleConosco/Edit/5
        // Para se proteger de mais ataques, habilite as propriedades específicas às quais você quer se associar. Para 
        // obter mais detalhes, veja https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID_FALE_CONOSCO,EMAIL,MENSAGEM,NOME_DO_REMETENTE,MENSAGEM_RESPOSTA,ID_FUNCIONARIO")] FaleConosco faleConosco)
        {
            if (ModelState.IsValid)
            {
                db.Entry(faleConosco).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(faleConosco);
        }

        // GET: FaleConosco/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            FaleConosco faleConosco = db.FaleConosco.Find(id);
            if (faleConosco == null)
            {
                return HttpNotFound();
            }
            return View(faleConosco);
        }

        // POST: FaleConosco/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            FaleConosco faleConosco = db.FaleConosco.Find(id);
            db.FaleConosco.Remove(faleConosco);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
