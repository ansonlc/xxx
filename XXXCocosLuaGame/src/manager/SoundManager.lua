SoundManager = {}

SoundManager.bgmList = {
    ['battle1'] = "res/sound/bgm_battle1.wav",
    ['battle2'] = "res/sound/bgm_battle2.wav",
    ['battle3'] = "res/sound/bgm_battle3.wav",
    ['battle4'] = "res/sound/bgm_battle4.wav",
    ['victory'] = "res/sound/bgm_victory.wav",
    ['menu'] = "res/sound/bgm_game.wav",
}

SoundManager.effectList = {
    ['attack'] = "res/sound/effect_attack.wav",
    ['heal'] = "res/sound/effect_heal.wav",
    ['recovery'] = "res/sound/effect_recovery.wav",
    ['silence'] = "res/sound/effect_silence.wav",
    ['skill'] = "res/sound/effect_skill.wav",  
    ['bleed'] = "res/sound/effect_bleed.wav",
    ['rune'] = "res/sound/effect_rune.wav",
}

function SoundManager.init()
    SoundManager.currentSound = nil 
end

function SoundManager.playBGM(name, isLoop)
    local test = SoundManager.currentSound
    if SoundManager.currentSound == nil then
        AudioEngine.playMusic(SoundManager.bgmList[name], isLoop)
        SoundManager.currentSound = name
    else
        if SoundManager.currentSound ~= name then
            AudioEngine.stopMusic(true)
            AudioEngine.playMusic(SoundManager.bgmList[name], isLoop)
            SoundManager.currentSound = name
        end
    end
end

function SoundManager.playEffect(name, isLoop)
    AudioEngine.playEffect(SoundManager.effectList[name], isLoop)
end

function SoundManager.stopMusic()
    AudioEngine.stopMusic(true)
    SoundManager.currentSound = nil
end