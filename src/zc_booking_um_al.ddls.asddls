@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Projection'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZC_BOOKING_UM_AL 
  as projection on ZI_BOOKING_UM_AL 
{
    // This creates the "Form" layout when you click 'Create' or 'Edit' on a Booking
    @UI.facet: [ { id: 'BookingDetails', 
                   type: #IDENTIFICATION_REFERENCE, 
                   label: 'Booking Info', 
                   position: 10 } ]

    key booking_uuid,
    
    @UI.hidden: true
    parent_uuid,
    
    @UI.lineItem: [{ position: 10 }]        // Shows as Column 1 in the Table
    @UI.identification: [{ position: 10 }]  // Shows in the Create/Edit form
    booking_id,
    
    @UI.lineItem: [{ position: 20 }]        // Shows as Column 2
    @UI.identification: [{ position: 20 }]
    local_last_changed_at,
    
    @UI.hidden: true
    last_changed_at,
    
    customer_id,
    
    /* Associations */
    _Travel : redirected to parent ZC_TRAVEL_UM_AL
}
