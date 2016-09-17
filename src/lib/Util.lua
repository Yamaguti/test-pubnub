

-- ===================
-- = Private Methods =
-- ===================

local function processPath(pathString)
    local pathInfo = {
        goBacks = 0;
    }
    local it = pathString:gmatch("%.%./")
    while it() do
        pathInfo.goBacks = pathInfo.goBacks + 1
    end

    pathInfo.path = pathString:match("[^%.%./].*")
    return pathInfo
end


local function processFolder(folder, pathInfo)
    for _ = 1, pathInfo.goBacks do
        folder = folder:gsub("[^%.]+%.?$", "")
    end

    return folder
end



-- ==================
-- = Global Methods =
-- ==================

function relativePath(path, launchArgs)
    local pathInfo = processPath(path)
    local folderOfThisFile = launchArgs:match("(.-)[^%.]+$")
    local folder = processFolder(folderOfThisFile, pathInfo)
    return folder .. pathInfo.path
end
