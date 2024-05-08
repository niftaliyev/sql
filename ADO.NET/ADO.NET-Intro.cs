using Microsoft.Data.SqlClient;
using System.Data;
using System.Reflection.PortableExecutable;

public class Program
{
    public static void Main()
    {
        //InsertData();
        //SelectData();
        //SelectDataToModel();
        //AggregationFunction();
        //AvoidSqlInjection();
        OutputParameter();
    }
    
    static void OutputParameter()
    {
        var connectionString = @"Data Source=DESKTOP-ACUMS98;Initial Catalog=LibrarySQL;Integrated Security=True;Connect Timeout=30;Encrypt=False;Trust Server Certificate=False;Application Intent=ReadWrite;Multi Subnet Failover=False";
        using (var connection = new SqlConnection(connectionString))
        {
            connection.Open();
            var query = @$"INSERT INTO Person(FullName,DateOfBirth) VALUES('Sebine','2005-07-25');SET @id = SCOPE_IDENTITY()";
            var command = new SqlCommand(query,connection);

            var idParam = new SqlParameter
            {
                ParameterName = "@id",
                SqlDbType = SqlDbType.Int,
                Direction = ParameterDirection.Output,
            };

            command.Parameters.Add(idParam);


            command.ExecuteNonQuery();

            var query2 = @$"SELECT * FROM Person WHERE Id = '{idParam.Value}'";
            var command2 = new SqlCommand(query2, connection);
            var reader = command2.ExecuteReader();

            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    var id = reader.GetValue(0);
                    Console.Write(id);

                    Console.Write('\t');

                    var fullName = reader.GetValue(1);
                    Console.Write(fullName);
                    Console.WriteLine();

                }
            }
            else
            {
                Console.WriteLine("Not found!!");
            }
        }
    }

    static void AvoidSqlInjection()
    {
        var connectionString = @"Data Source=DESKTOP-ACUMS98;Initial Catalog=LibrarySQL;Integrated Security=True;Connect Timeout=30;Encrypt=False;Trust Server Certificate=False;Application Intent=ReadWrite;Multi Subnet Failover=False";
        using (var connection = new SqlConnection(connectionString))
        {
            connection.Open();
            Console.Write("Enter Name: ");
            string Name = Console.ReadLine();
            var query = @$"INSERT INTO Person(FullName,DateOfBirth) VALUES((@Name),'2005-07-25')";

            var command = new SqlCommand(query, connection);
            command.Parameters.Add(new SqlParameter("@Name",Name));
            var result = command.ExecuteNonQuery();
            Console.WriteLine(result);
        }
        Console.WriteLine("Disconnected!!");
    }
    static void AggregationFunction()
    {
        var connectionString = @"Data Source=DESKTOP-ACUMS98;Initial Catalog=LibrarySQL;Integrated Security=True;Connect Timeout=30;Encrypt=False;Trust Server Certificate=False;Application Intent=ReadWrite;Multi Subnet Failover=False";
        using (var connection = new SqlConnection(connectionString))
        {
            connection.Open();
            var query = @"SELECT COUNT(*)
                          FROM Person";

            var command = new SqlCommand(query,connection);
            var result = (int)command.ExecuteScalar();
            Console.WriteLine(result);
        }
    }


    static void SelectDataToModel()
    {
        var connectionString = @"Data Source=DESKTOP-ACUMS98;Initial Catalog=LibrarySQL;Integrated Security=True;Connect Timeout=30;Encrypt=False;Trust Server Certificate=False;Application Intent=ReadWrite;Multi Subnet Failover=False";
        List<Person> people = new List<Person>();
        using (var connection = new SqlConnection(connectionString))
        {
            connection.Open();
            var query = @"SELECT *
                          FROM Person";

            var command = new SqlCommand(query, connection);
            var reader = command.ExecuteReader();

            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    var person = new Person();
                    var id = reader.GetInt32(0);
                    var fullName = reader.GetString(1);
                    var dateOfBirth = reader.GetDateTime(2);

                    person.Id = id;
                    person.FullName = fullName;
                    person.DateOfBirth = dateOfBirth;

                    people.Add(person);
                }
            }
            else
            {
                Console.WriteLine("Not found!!");
            }
            foreach (var person in people)
            {
                Console.WriteLine(person);
            }
        }
    }

    static void SelectData()
    {
        var connectionString = @"Data Source=DESKTOP-ACUMS98;Initial Catalog=LibrarySQL;Integrated Security=True;Connect Timeout=30;Encrypt=False;Trust Server Certificate=False;Application Intent=ReadWrite;Multi Subnet Failover=False";
        using (var connection = new SqlConnection(connectionString))
        {
            connection.Open();

            var query = @"SELECT *
                          FROM Person";

            var command = new SqlCommand(query, connection);
            var reader = command.ExecuteReader();

            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    var id = reader.GetValue(0);
                    Console.Write(id);

                    Console.Write('\t');

                    var fullName = reader.GetValue(1);
                    Console.Write(fullName);
                    Console.WriteLine();

                }
            }
            else
            {
                Console.WriteLine("Not found!!");
            }
        }
    }


    static void InsertData()
    {
        var connectionString = @"Data Source=DESKTOP-ACUMS98;Initial Catalog=LibrarySQL;Integrated Security=True;Connect Timeout=30;Encrypt=False;Trust Server Certificate=False;Application Intent=ReadWrite;Multi Subnet Failover=False";
        using (var connection = new SqlConnection(connectionString))
        {
            connection.Open();
            Console.WriteLine("Connected!!");

            var query = @"INSERT INTO Person(FullName,DateOfBirth) " +
                "           VALUES('Vusal Nerimanov','2005-07-25')";

            var command = new SqlCommand(query, connection);
            var result = command.ExecuteNonQuery();
            Console.WriteLine(result);
        }
        Console.WriteLine("Disconnected!!");
    }

    public class Person
    {
        public int Id { get; set; }
        public string FullName { get; set; }
        public DateTime DateOfBirth { get; set; }

        public override string ToString()
        {
            return $"Id: {Id} - FullName: {FullName} - DateOfBirth: {DateOfBirth}";
        }
    }
}