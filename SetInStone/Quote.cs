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
    
    public partial class Quote
    {
        public int QuoteId { get; set; }
        public Nullable<int> CustomerId { get; set; }
        public Nullable<int> SlabId { get; set; }
        public Nullable<double> Price { get; set; }
        public Nullable<int> EmployeeId { get; set; }
    
        public virtual Customer Customer { get; set; }
        public virtual Employee Employee { get; set; }
        public virtual Order Order { get; set; }
        public virtual Slab Slab { get; set; }
    }
}
