/**
 * @author: rafael.vital - topi
 */
public with sharing class TopiRunProjectRequest {

   public String name;
   public String code;
   public String status;
   public Date startDate;
   public Date endDate;
   public Double budget;

   public TopiRunProjectRequest () {
     this.budget = 1000000;
   }

   override 
   public String toString() {
     return JSON.serialize(this);
   }

}