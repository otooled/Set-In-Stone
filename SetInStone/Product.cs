//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SetInStone
{
    using System;
    using System.Collections.Generic;
    
    public partial class Product
    {
        public Product()
        {
            this.Quotes = new HashSet<Quote>();
        }
    
        public int ProductID { get; set; }
        public Nullable<double> Height { get; set; }
        public Nullable<double> Width { get; set; }
        public Nullable<double> Length { get; set; }
        public Nullable<double> PyrHeight { get; set; }
        public Nullable<int> ProductOptionID { get; set; }
        public Nullable<int> StoneId { get; set; }
    
        public virtual ProductOption ProductOption { get; set; }
        public virtual Stone Stone { get; set; }
        public virtual ICollection<Quote> Quotes { get; set; }
    }
}
