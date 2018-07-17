import ballerina/http;
import ballerina/log;
import ballerina/mysql;
import ballerina/io;

endpoint mysql:Client testDB {
    host: "localhost",
    port: 3306,
    name: "perftestballerina",
    username: "root",
    password: "123",
    poolOptions: { maximumPoolSize: 1000 },
    dbOptions: { useSSL: false }
};

type Employee record {
    int id,
    string name,
};

type myType int|string;

// By default, Ballerina assumes that the service is to be exposed via HTTP/1.1.
service<http:Service> hello bind { port: 9090 } {

    // All resources are invoked with arguments of server connector and request.
    sayHello(endpoint caller, http:Request req) {
        http:Response res = new;
        // A util method that can be used to set a string payload.
        res.setPayload("Hello, World!");

        // Sends the response back to the caller.
        caller->respond(res) but {
            error e => log:printError("Error sending response", err = e)
        };
    }

    // curl -v http://localhost:9090/hello/select
    select(endpoint caller, http:Request req) {
        http:Response res = new;

        table<Employee> dt = check testDB->select("select * from selecttest where id = 1", Employee);

        json employees = <json>dt but {
            error e => log:printError("Error converting table to json", err = e)
        };

        res.setPayload(untaint employees);

        caller->respond(res) but {
            error e => log:printError("Error sending response", err = e)
        };
    }

    // curl -v http://localhost:9090/hello/select
    select100(endpoint caller, http:Request req) {
        http:Response res = new;

        table<Employee> dt = check testDB->select("select * from selecttest where id < 101", Employee);

        json employees = <json>dt but {
            error e => log:printError("Error converting table to json", err = e)
        };

        res.setPayload(untaint employees);

        caller->respond(res) but {
            error e => log:printError("Error sending response", err = e)
        };
    }

    // curl -v http://localhost:9090/hello/insert -d'{"id":4, "name":"C"}' -H'Content-Type:application/json'
    @http:ResourceConfig {
        methods: ["POST"]
    }
    insert(endpoint caller, http:Request req) {
        http:Response res = new;
        json employee = check req.getJsonPayload();

        _ = testDB->update("insert into inserttest values(?, ?)", employee.id.toString(), employee.name.toString());

        caller->respond(res) but {
            error e => log:printError("Error sending response", err = e)
        };
    }

    // curl -v http://localhost:9090/hello/delete -d'{"id":4}' -H'Content-Type:application/json'
    @http:ResourceConfig {
        methods: ["POST"]
    }
    delete(endpoint caller, http:Request req) {
        http:Response res = new;
        json payload = check req.getJsonPayload();

        _ = testDB->update("delete from Employee where id = ?", payload.id.toString());

        caller->respond(res) but {
            error e => log:printError("Error sending response", err = e)
        };
    }


    // curl -v http://localhost:9090/hello/batchinsert -d'{"employee":[{"id":7, "name":"F"},{"id":8,"name":"G"}]}' -H'Content-Type:application/json'
    @http:ResourceConfig {
        methods: ["POST"]
    }
    batchinsert(endpoint caller, http:Request req) {
        http:Response res = new;
        json employees = check req.getJsonPayload();

        int noOfEmployees = lengthof employees.employee;
        int i = 0;

        myType[][] employeeInfoArray;
        while (i < noOfEmployees) {
            int id = check <int> employees.employee[i].id;
            string name = check <string> employees.employee[i].name;

            myType [] parameters = [id, name];
            employeeInfoArray[i] = parameters;

            i = i + 1;
        }
        _ = testDB->batchUpdate("insert into batchinserttest values(?, ?)", ...employeeInfoArray);

        caller->respond(res) but {
            error e => log:printError("Error sending response", err = e)
        };
    }
}
