require("battle.SkillTable")

SkillManager={}

function SkillManager.getSkill(skillID)
   if SkillManager.SkillTable == nil 
   then
        SkillManager.SkillTable = getSkillTable()
   end
   local skill = SkillManager.SkillTable[skillID]
   return skill
end