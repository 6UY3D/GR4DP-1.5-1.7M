local openssl = require("openssl")

function tokenize_text(text)
    local tokens = {}
    for word in text:gmatch("%w+") do
        table.insert(tokens, word)
    end
    return tokens
end

function preprocess_text(file, output_dir, id)
    local f = io.open(file, "r")
    if not f then
        error("Failed to open file: " .. file)
    end
    local text = f:read("*all")
    f:close()
    local tokens = tokenize_text(text)
    local binary = ""
    for _, token in ipairs(tokens) do
        binary = binary .. token .. "\0"
    end
    local hash = openssl.sha256(binary)
    local output_file = output_dir .. "/" .. id .. ".bin"
    local f = io.open(output_file, "wb")
    if not f then
        error("Failed to open output file: " .. output_file)
    end
    f:write(binary)
    f:close()
    return hash
end

-- Example usage: preprocess_text("text.txt", "output", 1)
