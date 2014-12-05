-- Generated from template
hulage=0
if mgdbfGameMode == nil then
	mgdbfGameMode = class({})
end

function Precache( context )
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
end

-- Create the game mode when we activate
function Activate()
	GameRules.AddonTemplate = mgdbfGameMode()
	GameRules.AddonTemplate:InitGameMode()
end

function mgdbfGameMode:InitGameMode()
	print( "Template addon is loaded." )
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 2 )

    --注册英雄行走方向命令

    Convars:RegisterCommand( "UpWalking", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:WalkingUp(cmdPlayer) 
    end
    end, "walking up", 0 )

    Convars:RegisterCommand( "DownWalking", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:WalkingDown(cmdPlayer) 
    end
    end, "walking down", 0 )

    Convars:RegisterCommand( "LeftWalking", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:WalkingLeft(cmdPlayer) 
    end
    end, "walking left", 0 )

    Convars:RegisterCommand( "RightWalking", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:WalkingRight(cmdPlayer) 
    end
    end, "walking right", 0 )    

 --注册英雄行走方向结束命令

    Convars:RegisterCommand( "UpWalkingDone", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:WalkingUpDone(cmdPlayer) 
    end
    end, "walking up Done", 0 )

    Convars:RegisterCommand( "DownWalkingDone", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:WalkingDownDone(cmdPlayer) 
    end
    end, "walking down Done", 0 )

    Convars:RegisterCommand( "LeftWalkingDone", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:WalkingLeftDone(cmdPlayer) 
    end
    end, "walking left Done", 0 )

    Convars:RegisterCommand( "RightWalkingDone", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:WalkingRightDone(cmdPlayer) 
    end
    end, "walking right Done", 0 )  


end

-- Evaluate the state of the game
function mgdbfGameMode:OnThink()
	if hulage==0 then
        hulage=1

         SendToConsole("dota_sf_hud_inventory 0")
         SendToConsole("dota_render_crop_height 0")

      end

	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		--print( "Template addon script is running." )
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	return 1
end

--行走开始
function mgdbfGameMode:WalkingUp(player)
  print("get walking up!")
  local hero=player:GetAssignedHero()       --获得玩家操控英雄
  local vec=hero:GetAbsOrigin()
  local newvec   
  newvec=Vector(vec.x,vec.y+500,vec.z)      --获得行走方向
  walk(hero,newvec)                         --走过去
end

function mgdbfGameMode:WalkingDown(player)
  print("get walking down!")
  local hero=player:GetAssignedHero()
  local vec=hero:GetAbsOrigin()
  local newvec
  newvec=Vector(vec.x,vec.y-500,vec.z)
  walk(hero,newvec)
end

function mgdbfGameMode:WalkingLeft(player)
  print("get walking left!")
  local hero=player:GetAssignedHero()
  local vec=hero:GetAbsOrigin()
  local newvec
  newvec=Vector(vec.x-500,vec.y,vec.z)
  walk(hero,newvec)
end

function mgdbfGameMode:WalkingRight(player)
  print("get walking right!")
  local hero=player:GetAssignedHero()
  local vec=hero:GetAbsOrigin()
  local newvec
  newvec=Vector(vec.x+500,vec.y,vec.z)
  walk(hero,newvec)
end

--行走结束
function mgdbfGameMode:WalkingUpDone(player)
  print("get walking up Done!")  
  local hero=player:GetAssignedHero()
  hero:Stop();
end

function mgdbfGameMode:WalkingDownDone(player)
  print("get walking down Done!")
  local hero=player:GetAssignedHero()
  hero:Stop();
end

function mgdbfGameMode:WalkingLeftDone(player)
  print("get walking left Done!")
  local hero=player:GetAssignedHero()
  hero:Stop();
end

function mgdbfGameMode:WalkingRightDone(player)
  print("get walking right Done!")
  local hero=player:GetAssignedHero()
  hero:Stop();
end


--行走函数
function walk(unit,position)
  local newOrder = {
         
    UnitIndex = unit:entindex(),             
    OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,  
    TargetIndex = nil,                   
    AbilityIndex = 0,                             
    Position = position,                
    Queue = 0                       
  }
          
  ExecuteOrderFromTable(newOrder)
end