unit DataGenerator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.DateUtils, System.StrUtils, System.Math;

type
  TCountryCapital = record
    Country : string;
    Capital : string;
  end;

  TDataGenerator = class
  private



  public

    class function GetRandomFirstName : string;
    class function GetRandomLastName : string;
    class function GenerateRandomEmail : string;
    class function GenerateRandomPhoneNumber : string;
    class function GetCountryAndCapital(Index : Integer) : TCountryCapital;
    class function GenerateRandomJobTitle : string;
    class function GenerateRandomCompany : string;
    class function GenerateRandomString : string;
    class function GenerateRandomDate(StartDate, EndDate : TDate) : TDate;
    class function GenerateRandomDateTime(StartDate, EndDate : TDateTime) : TDateTime;
    class function GenerateRandomTime(StartTime, EndTime : TTime) : TTime;
    class function RandomRangeDecimal(Min, Max : Double) : Double;
  end;

implementation

const
  ListadoNombres : array[0..34] of string = ('Adam', 'Alex', 'Mario', 'Jonathan', 'Carlos', 'Juan', 'David',
                                             'Eduardo', 'Fredi', 'Frank', 'Agustin', 'Mariela', 'Marcos', 'Jose',
                                             'Madeline', 'Elizabet', 'Ruth', 'Elena', 'Enmanuel', 'Wendy', 'Maria',
                                             'Natanael', 'Samuel', 'Pablo', 'Pedro', 'Roger', 'Ivelise', 'Elva',
                                             'Tomas', 'Erika', 'Jorge', 'Victor', 'Walter', 'Paola', 'Betty');

  ListadoApellidos : array[0..125] of string = ('García', 'Rodríguez', 'Martínez', 'Hernández', 'López', 'González', 'Pérez',
                'Sánchez', 'Ramírez', 'Torres', 'Flores', 'Rivera', 'Gómez', 'Díaz',
                'Reyes', 'Morales', 'Cruz', 'Ortiz', 'Gutiérrez', 'Jiménez', 'Mendoza',
                'Romero', 'Castillo', 'Vázquez', 'Ramos', 'Vega', 'Ruiz', 'Castro',
                'Delgado', 'Espinoza', 'Méndez', 'Silva', 'Guzmán', 'Molina', 'Castro',
                'Lozano', 'Alvarez', 'Herrera', 'Marquez', 'Peña', 'Guerrero', 'Rivas',
                'Sosa', 'Navarro', 'Solís', 'Campos', 'Vargas', 'Cervantes', 'Pineda',
                'Aguilar', 'Salazar', 'Quintero', 'Rojas', 'Zamora', 'Cardenas', 'Cortés',
                'Ayala', 'Gallegos', 'Ochoa', 'Rangel', 'Montoya', 'Ortega', 'Rubio',
                'Maldonado', 'Valdez', 'Padilla', 'Serrano', 'Acosta', 'Aguirre', 'Escobar',
                'Salinas', 'Valencia', 'Barrios', 'Carrillo', 'Peñaloza', 'Fuentes',
                'Arroyo', 'Villanueva', 'Montero', 'Barrera', 'Navarrete', 'Salgado',
                'Medina', 'Santos', 'Escalante', 'Nieto', 'Peralta', 'Zarate', 'Bautista',
                'Roldán', 'Santillán', 'Paz', 'Pacheco', 'Cano', 'Bravo', 'Nava', 'Arias',
                'Solano', 'Sierra', 'Godoy', 'Moreno', 'Páez', 'Calderón', 'Castañeda',
                'Villalobos', 'Portillo', 'Lara', 'Márquez', 'Amador', 'Solano', 'Ferrera',
                'Ponce', 'Felipe', 'Luna', 'Collado', 'Duarte', 'Pozo', 'Mejía', 'Varela',
                'Benítez', 'Manzano', 'Suárez', 'Varela', 'Cabrera', 'Santacruz', 'Vallejo');

class function TDataGenerator.GetRandomFirstName : string;
begin
  Result := ListadoNombres[Random(Length(ListadoNombres))];
end;

class function TDataGenerator.GetRandomLastName : string;
begin
  Result := ListadoApellidos[Random(Length(ListadoApellidos))];
end;

class function TDataGenerator.GenerateRandomEmail : string;
const
  Providers : array[1..10] of string = (
    'hubspot.com', 'gmail.com', 'protonmail.com', 'icloud.com', 'zohomail.com',
    'outlook.com', 'mailbox.org', 'yahoo.com', 'bluehost.com', 'rackspace.com');
var
  LocalPart, Domain : string;
begin
  LocalPart := 'user' + IntToStr(Random(10000));
  Domain    := Providers[Random(Length(Providers)) + 1];
  Result    := LocalPart + '@' + Domain;
end;

class function TDataGenerator.GenerateRandomPhoneNumber : string;
const
  AreaCodes : array[1..20] of string = (
    '212', '305', '323', '415', '520',  // Algunos codigos de area de EE.UU.
    '809', '829', '849',               // Codigos de area de Republica Dominicana
    '506',                            // Codigo de area de Costa Rica
    '55', '81',                       // Codigos de area de Mexico
    '0212', '0412', '0414',           // Codigos de area de Venezuela
    '011', '351',                     // Codigos de area de Argentina
    '02', '04',                       // Codigos de area de Ecuador
    '57', '44'                        // Codigos de area de Peru y UK (ejemplo diverso)
  );

var
  LocalNumber, AreaCode : string;
begin
  AreaCode    := AreaCodes[Random(Length(AreaCodes)) + 1];
  LocalNumber := Format('%.7d', [Random(10000000)]);
  Result      := '(' + AreaCode + ') ' + Copy(LocalNumber, 1, 3) + '-' + Copy(LocalNumber, 4, 4);
end;

class function TDataGenerator.GetCountryAndCapital(Index : Integer) : TCountryCapital;

//DECLARAMOS UN ARRAY DE ACUERDO AL TIPO DEFINIDO Y LO INICIALIZAMOS
const
  CountryData : array[0..19] of TCountryCapital = (
   (Country : 'Venezuela'; Capital : 'Caracas'),
   (Country : 'Argentina'; Capital : 'Buenos Aires'),
   (Country : 'Estados Unidos'; Capital : 'Washington'),
   (Country : 'México'; Capital : 'Ciudad de México'),
   (Country : 'Brasil'; Capital : 'Brasilia'),
   (Country : 'Colombia'; Capital : 'Bogotá'),
   (Country : 'Perú'; Capital : 'Lima'),
   (Country : 'Chile'; Capital : 'Santiago de Chile'),
   (Country : 'Ecuador'; Capital : 'Quito'),
   (Country : 'Uruguay'; Capital : 'Montevideo'),
   (Country : 'Canadá'; Capital : 'Ottawa'),
   (Country : 'Paraguay'; Capital : 'Asunción'),
   (Country : 'Bolivia'; Capital : 'Sucre'),
   (Country : 'Guatemala'; Capital : 'Ciudad de Guatemala'),
   (Country : 'Cuba'; Capital : 'La Habana'),
   (Country : 'España'; Capital : 'Madrid'),
   (Country : 'Portugal'; Capital : 'Lisboa'),
   (Country : 'Francia'; Capital : 'París'),
   (Country : 'Alemania'; Capital : 'Berlín'),
   (Country : 'Italia'; Capital : 'Roma'));

begin
  Result.Country := CountryData[Index].Country;
  Result.Capital := CountryData[Index].Capital;
end;

class function TDataGenerator.GenerateRandomJobTitle : string;
const
  JobTitles : array[0..25] of string = (
    'Supervisor', 'Associate', 'Executive', 'Liason', 'Officer',
    'Manager', 'Engineer', 'Specialist', 'Director', 'Coordinator',
    'Administrator', 'Architect', 'Analyst', 'Designer', 'Planner',
    'Synergist', 'Orchestrator', 'Technician', 'Developer', 'Producer',
    'Consultant', 'Assistant', 'Facilitator', 'Agent', 'Representative',
    'Strategist');
begin
  Result := JobTitles[Random(Length(JobTitles))];
end;

class function TDataGenerator.GenerateRandomCompany : string;
const
  Companies : array[0..49] of string = (
    'Bed Bath & Beyond', 'EMCOR Group', 'Tyson Foods', 'Capital One Financial',
    'Albertsons', 'Tesla', 'Alaska Air Group', 'Norfolk Southern', 'World Fuel Services',
    'MGM Resorts International', 'Caesars Entertainment', 'Cheniere Energy',
    'United Continental Holdings', 'Sherwin-Williams', 'Ingredion', 'Charles Schwab',
    'ABM Industries', 'Windstream Holdings', 'NetApp', 'Bank of America',
    'Advanced Micro Devices', 'Dick''s Sporting Goods', 'McKesson', 'Henry Schein',
    'W.R. Berkley', 'Owens-Illinois', 'Robert Half International', 'IQVIA Holdings',
    'Land O''Lakes', 'Kellogg', 'Walmart', 'Amgen', 'Walt Disney', 'General Motors',
    'Aflac', 'Republic Services', 'Adobe', 'Cintas', 'Graphic Packaging Holding',
    'Dollar Tree', 'Southern', 'Johnson & Johnson', 'XPO Logistics', 'Performance Food Group',
    'Markel', 'CarMax', 'Dean Foods', 'Alliance Data Systems', 'Targa Resources',
    'Guardian Life Ins. Co. of America');
begin
  Result := Companies[Random(Length(Companies))];
end;

class function TDataGenerator.GenerateRandomString : string;
const
  PossibleChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
var
  I, StrLength : Integer;
begin
  StrLength := Random(10) + 5;
  Result    := '';
  for I := 1 to StrLength do
    Result := Result + PossibleChars[Random(Length(PossibleChars)) + 1];
end;

class function TDataGenerator.GenerateRandomDate(StartDate, EndDate : TDate) : TDate;
var
  Range : Integer;
begin
  // Asegúrate de que StartDate sea menor que EndDate
  if StartDate > EndDate then
    begin
      StartDate := EndDate;
      EndDate   := StartDate;
    end;

  Range  := DaysBetween(EndDate, StartDate);
  Result := IncDay(StartDate, Random(Range + 1));
end;

class function TDataGenerator.GenerateRandomDateTime(StartDate, EndDate : TDateTime) : TDateTime;
var
  RandomDate, RandomTime : TDateTime;
begin
  // Asegúrate de que StartDate sea menor que EndDate
  if StartDate > EndDate then
    begin
      StartDate := EndDate;
      EndDate   := StartDate;
    end;

  RandomDate := StartDate + Random(DaysBetween(EndDate, StartDate) + 1);
  RandomTime := EncodeTime(Random(24), Random(60), Random(60), Random(1000));
  Result     := RandomDate + RandomTime;
end;

class function TDataGenerator.GenerateRandomTime(StartTime, EndTime : TTime) : TTime;
var
  MinutesRange, RandomMinutes : Integer;
begin
  // Asegúrate de que StartTime sea menor que EndTime
  if StartTime > EndTime then
    begin
      StartTime := EndTime;
      EndTime   := StartTime;
    end;

  MinutesRange  := MinutesBetween(EndTime, StartTime);
  RandomMinutes := Random(MinutesRange + 1);
  Result        := IncMinute(StartTime, RandomMinutes);
end;

class function TDataGenerator.RandomRangeDecimal(Min, Max : Double) : Double;
begin
  Result := Min + Random * (Max - Min);
end;

end.
