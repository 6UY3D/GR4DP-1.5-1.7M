local image = require("image")
local openssl = require("openssl")

function preprocess_image(file, output_dir, id)
    local img = image.load(file)
    if not img then
        error("Failed to load image: " .. file)
    end
    img = image.scale(img, 32, 32)
    img = img / 255.0
    local binary = ""
    for i = 1, img:size(1) do
        for j = 1, img:size(2) do
            for c = 1, img:size(3) do
                binary = binary .. string.pack("f", img[i][j][c])
            end
        end
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

-- Example usage: preprocess_image("image.jpg", "output", 1)
