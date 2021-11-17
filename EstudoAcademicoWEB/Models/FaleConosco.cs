using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace EstudoAcademicoWEB.Models
{
    [Table("fale_conosco")]
    public class FaleConosco
    {

        private readonly static string _hotelDBContext = WebConfigurationManager.ConnectionStrings["HotelDBContext"].ConnectionString;
        [Key]
        public int ID_FALE_CONOSCO { get; set; }
        public string EMAIL { get; set; }
        public string MENSAGEM { get; set; }
        public string NOME_DO_REMETENTE { get; set; }
    }

    public class HotelDBContext : DbContext
    {
        public DbSet<FaleConosco> FaleConosco { get; set; }
    }
}