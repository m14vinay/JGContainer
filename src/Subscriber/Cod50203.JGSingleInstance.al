codeunit 50203 "JGSingleInstance"
{
    SingleInstance = true;
    procedure SetWhseShipNo(ShipNo : Code[20])
    begin
       WHseShpNo := ShipNo;
    end;
    procedure GetWhseShipNo() : Code[20]
    var
    GetShipNo : Code[20];
    begin
      Exit(WHseShpNo);
    end;
     procedure SetShipNo(ShipNo : Code[20])
    begin
       DONo := ShipNo;
    end;
    procedure GetShipNo() : Code[20]
    begin

      
      Exit(DONo);
    end;
    var
    WHseShpNo : Code[20];
    DONo : Code[20];
}
