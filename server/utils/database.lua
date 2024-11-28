get, post = {}, {}


-- Get Data From Database
function get.VehicleStock(id)
    local variable = MySQL.query.await('SELECT * FROM `Dealership_VehicleStock` WHERE `dealership_id` = @id', {['@id'] = id})
    for _, results in pairs(variable) do return results ~= {} and variable or nil end
end

function get.DealershipDetail(id)
    local variable = MySQL.query.await('SELECT * FROM Dealership_Details WHERE id = @id', {['@id'] = id})
    return variable
end




-- Post Data To Database
function post.Dealership(args)
    MySQL.insert('INSERT INTO Dealership_Details (id, owner, name, amountTotal, employeers) VALUES (@id, @owner, @name, @amount, @employeers)', 
        {
            ['@id'] = args.id, 
            ['@owner'] = args.owner, 
            ['@name'] = args.name, 
            ['@amount'] = args.amount, 
            ['@employeers'] = args.employeers
        }
    )
end