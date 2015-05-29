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
    SoundManager.currentEffect = nil
    SoundManager.isMusicOn = true
    SoundManager.isEffectOn = true 
    --add volume
    SoundManager.bgmVolume = 1.0
    SoundManager.effectVolume = 1.0
end

function SoundManager.playBGM(name, isLoop)
    local test = SoundManager.currentSound
    --SoundManager.isMusicOn = true
    if SoundManager.isMusicOn then 
        if SoundManager.currentSound == nil then
            AudioEngine.playMusic(SoundManager.bgmList[name], isLoop)
            SoundManager.currentSound = name
        else
            if SoundManager.currentSound ~= name then
                AudioEngine.stopMusic(true)
                AudioEngine.playMusic(SoundManager.bgmList[name], isLoop)
	            --set volume
                AudioEngine.setMusicVolume(SoundManager.bgmVolume)
                SoundManager.currentSound = name
            end
       end
    end
end

function SoundManager.stopMusic()
    if SoundManager.isMusicOn then
        AudioEngine.stopMusic(true)
        SoundManager.currentSound = nil
    end
end

function SoundManager.pauseMusic()
    --if SoundManager.isMusicOn then
        AudioEngine.pauseMusic()
    --end
end

function SoundManager.resumeMusic()
    --if SoundManager.isMusicOn then
        AudioEngine.resumeMusic()
    --end
end

function SoundManager.noMusic()
    SoundManager.isMusicOn = false
end

function SoundManager.switchMusic()
    if SoundManager.isMusicOn then 
        SoundManager.pauseMusic()
        SoundManager.isMusicOn = false        
    else
         SoundManager.isMusicOn = true
        SoundManager.resumeMusic()
    end
end

function SoundManager.musicVolumeUp()
    if SoundManager.bgmVolume ~= 1 then
        SoundManager.bgmVolume = SoundManager.bgmVolume + 0.1
        AudioEngine.setMusicVolume(SoundManager.bgmVolume)
    end
end

function SoundManager.musicVolumeDown()
    if SoundManager.bgmVolume ~= 0 then
        SoundManager.bgmVolume = SoundManager.bgmVolume - 0.1
        AudioEngine.setMusicVolume(SoundManager.bgmVolume)
    end
end

function SoundManager.playEffect(name, isLoop)
    if SoundManager.isEffectOn then
        SoundManager.currentEffect = AudioEngine.playEffect(SoundManager.effectList[name], isLoop)
        --set volume
        AudioEngine.setEffectsVolume(SoundManager.effectVolume)
    end
end

function SoundManager.pauseEffect()
    --if SoundManager.isEffectOn then
        AudioEngine.pauseEffect(SoundManager.currentEffect)
    --end
end

function SoundManager.resumeEffect()
    --if SoundManager.isEffectOn then
        AudioEngine.resumeEffect(SoundManager.currentEffect)
    --end
end

function SoundManager.noEffect()
    SoundManager.isEffectOn = false
end

function SoundManager.switchEffect()
    if SoundManager.isEffectOn then 
        SoundManager.isEffectOn = false
        SoundManager.pauseEffect()
    else
        SoundManager.isEffectOn = true
        SoundManager.resumeEffect()
    end
end

function SoundManager.effectVolumeUp()
    if SoundManager.effectVolume ~= 1 then
        SoundManager.effectVolume = SoundManager.effectVolume + 0.1
        AudioEngine.setEffectsVolume(SoundManager.effectVolume)
    end
end

function SoundManager.effectVolumeDown()
    if SoundManager.effectVolume ~= 0 then
        SoundManager.effectVolume = SoundManager.effectVolume - 0.1
        AudioEngine.setEffectsVolume(SoundManager.effectVolume)
    end
end

