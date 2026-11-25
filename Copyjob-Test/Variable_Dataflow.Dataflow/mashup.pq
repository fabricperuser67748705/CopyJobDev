[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "holidaydatacontainer_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "countryOrRegion", DestinationColumnName = "countryOrRegion"], [SourceColumnName = "holidayName", DestinationColumnName = "holidayName"], [SourceColumnName = "normalizeHolidayName", DestinationColumnName = "normalizeHolidayName"], [SourceColumnName = "isPaidTimeOff", DestinationColumnName = "isPaidTimeOff"], [SourceColumnName = "countryRegionCode", DestinationColumnName = "countryRegionCode"], [SourceColumnName = "date", DestinationColumnName = "date"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared holidaydatacontainer = let
  Source = Lakehouse.Contents([]),
  Navigation = Source{[workspaceId = WorkspaceID]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = LakehouseID]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "holidaydatacontainer", ItemKind = "Table"]}[Data],
  #"Filtered rows" = Table.SelectRows(#"Navigation 2", each [countryOrRegion] = Region)
in
  #"Filtered rows";
shared WorkspaceID = let
    WorkspaceId = Variable.ValueOrDefault("$(/**/dataflow-Variables/WorkspaceId)", "1afc3984-afc2-4943-b631-dfa1f74f1f2e")
in
    WorkspaceId;
shared LakehouseID = let
    LakehouseId = Variable.ValueOrDefault("$(/**/dataflow-Variables/LakehouseId)", "883836dd-0acc-4e68-a801-99dbd1e026d8")
in
    LakehouseId;
shared Region = let
    Source = Variable.ValueOrDefault("$(/**/dataflow-Variables/Region)", "Sweden")
in
    Source;
shared holidaydatacontainer_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = true, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "1afc3984-afc2-4943-b631-dfa1f74f1f2e"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "daa2d52f-1799-4f5c-9ba7-6be11c952903"]}[Data],
  Navigation_3 = Navigation_2{[Schema = "dbo"]}[Data],
  TableNavigation = Navigation_3{[Name = "holidaydatacontainer"]}?[Data]?
in
  TableNavigation;
