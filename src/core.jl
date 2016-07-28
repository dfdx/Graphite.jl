
type GraphiteConn
    host::AbstractString
    port::Int
    sock::TCPSocket
end

function GraphiteConn(host::AbstractString, port::Int)
    sock = connect(host, port)
    return GraphiteConn(host, port, sock)
end

function Base.show(io::IO, g::GraphiteConn)
    print(io, "GraphiteConn($(g.host):$(g.port))")
end

function send_metric(g::GraphiteConn, path::AbstractString, value::Number, t::Int64)    
    write(g.sock, "$path $value $t\n")
end

function send_metric(g::GraphiteConn, path::AbstractString, value::Number)
    t = floor(Int, time())
    send_metric(g, path, value, t)
end
