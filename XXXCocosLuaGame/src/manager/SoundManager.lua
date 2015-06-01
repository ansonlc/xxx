SoundManager = {}

SoundManager.bgmList = {
    ['battle1'] = "res/sound/bgm_battle1.mp3",
    ['battle2'] = "res/sound/bgm_battle2.mp3",
    ['battle3'] = "res/sound/bgm_battle3.mp3",
    ['battle4'] = "res/sound/bgm_battle4.mp3",
    ['victory'] = "res/sound/bgm_victory.mp3",
    ['menu'] = "res/sound/bgm_game.mp3",
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
    SoundManager.currentMusic = nil
    SoundManager.pausedMusic = nil
    SoundManager.currentEffect = nil
    SoundManager.isMusicOn = true
    SoundManager.isEffectOn = true 
    SoundManager.bgmVolume = 1.0
    SoundManager.effectVolume = 1.0
end

function SoundManager.playBGM(name, isLoop)
    --[[if SoundManager.isMusicOn then 
        if SoundManager.currentMusic == nil then
            AudioEngine.playMusic(SoundManager.bgmList[name], isLoop)
            SoundManager.currentMusic = name
        else
            if SoundManager.currentMusic ~= name then
                AudioEngine.stopMusic(true)
                AudioEngine.playMusic(SoundManager.bgmList[name], isLoop)
	            --set volume
                AudioEngine.setMusicVolume(SoundManager.bgmVolume)
                SoundManager.currentMusic = name
            end
       end    
    end]]--    
     
    if SoundManager.currentMusic ~= name then
        SoundManager.currentMusic = name
        if SoundManager.isMusicOn then
            if SoundManager.currentMusic ~= nil then
                AudioEngine.stopMusic(true)
            end
            AudioEngine.playMusic(SoundManager.bgmList[name], isLoop)
            AudioEngine.setMusicVolume(SoundManager.bgmVolume)        
        end    
    end
end

function SoundManager.stopMusic()
    if SoundManager.isMusicOn then
        AudioEngine.stopMusic(true)
        SoundManager.currentMusic = nil
    end
end

function SoundManager.pauseMusic()
    SoundManager.isMusicOn = false
    SoundManager.pausedMusic = SoundManager.currentMusic
    AudioEngine.pauseMusic()    
end

function SoundManager.resumeMusic()
    SoundManager.isMusicOn = true
    if SoundManager.pausedMusic == SoundManager.currentMusic then
        AudioEngine.resumeMusic()
    else        
        --SoundManager.playBGM(SoundManager.currentMusic,true)
        AudioEngine.playMusic(SoundManager.bgmList[SoundManager.currentMusic], true)
        AudioEngine.setMusicVolume(SoundManager.bgmVolume)
    end
end

function SoundManager.noMusic()
    SoundManager.isMusicOn = false
end

function SoundManager.switchMusic()
    if SoundManager.isMusicOn then 
        SoundManager.pauseMusic()                
    else         
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
    SoundManager.isEffectOn = false
    if SoundManager.currentEffect ~= nil then
        AudioEngine.pauseEffect(SoundManager.currentEffect)
    end
end

function SoundManager.resumeEffect()
    SoundManager.isEffectOn = true
    if SoundManager.currentEffect ~= nil then
        AudioEngine.resumeEffect(SoundManager.currentEffect)
    end
end

function SoundManager.noEffect()
    SoundManager.isEffectOn = false
end

function SoundManager.switchEffect()
    if SoundManager.isEffectOn then 
        SoundManager.pauseEffect()
    else
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

