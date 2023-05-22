reportextension 50111 ZYStandardSalesOrderConfExt extends "Standard Sales - Order Conf."
{
    dataset
    {
        add(Header)
        {
            column(CustPicture; CustTenantMedia.Content)
            {
            }
        }
        add(Line)
        {
            column(ItemPicture; ItemTenantMedia.Content)
            {
            }
        }
        modify(Header)
        {
            trigger OnAfterAfterGetRecord()
            var
                Cust: Record Customer;
            begin
                if Cust.Get("Sell-to Customer No.") then
                    if Cust.Image.HasValue then begin
                        CustTenantMedia.Get(Cust.Image.MediaId);
                        CustTenantMedia.CalcFields(Content);
                    end;
            end;
        }
        modify(Line)
        {
            trigger OnAfterAfterGetRecord()
            var
                Item: Record Item;
            begin
                if Type = Type::Item then
                    if Item.Get("No.") then
                        if Item.Picture.Count > 0 then begin
                            ItemTenantMedia.Get(Item.Picture.Item(1));
                            ItemTenantMedia.CalcFields(Content);
                        end;
            end;
        }
    }

    var
        CustTenantMedia: Record "Tenant Media";
        ItemTenantMedia: Record "Tenant Media";
}
