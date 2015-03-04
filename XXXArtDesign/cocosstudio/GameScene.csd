<GameProjectFile>
  <PropertyGroup Type="Scene" Name="GameScene" ID="d9e0d6ba-66e7-4e7a-ae42-ba4e0ccac61e" Version="2.0.5.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="1.0000" />
      <ObjectData Name="Scene" FrameEvent="" Tag="20" ctype="SingleNodeObjectData">
        <Position X="0.0000" Y="0.0000" />
        <Scale ScaleX="1.0000" ScaleY="1.0000" />
        <AnchorPoint />
        <CColor A="255" R="255" G="255" B="255" />
        <Size X="1080.0000" Y="1920.0000" />
        <PrePosition X="0.0000" Y="0.0000" />
        <PreSize X="0.0000" Y="0.0000" />
        <Children>
          <NodeObjectData Name="main_menu_bg" ActionTag="1183218263" FrameEvent="" Tag="21" ObjectIndex="1" ctype="SpriteObjectData">
            <Position X="0.0000" Y="0.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <AnchorPoint />
            <CColor A="255" R="255" G="255" B="255" />
            <Size X="1080.0000" Y="1920.0000" />
            <PrePosition X="0.0000" Y="0.0000" />
            <PreSize X="0.0000" Y="0.0000" />
            <FileData Type="Normal" Path="imgs/main_menu_bg.png" />
          </NodeObjectData>
          <NodeObjectData Name="panel_battle" ActionTag="1777186065" FrameEvent="" Tag="22" ObjectIndex="1" TouchEnable="True" BackColorAlpha="0" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="1000" Scale9Height="620" ctype="PanelObjectData">
            <Position X="40.0000" Y="1265.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <AnchorPoint />
            <CColor A="255" R="255" G="255" B="255" />
            <Size X="1000.0000" Y="620.0000" />
            <PrePosition X="0.0370" Y="0.6589" />
            <PreSize X="0.9259" Y="0.3229" />
            <Children>
              <NodeObjectData Name="level_info" ActionTag="1812552024" FrameEvent="" Tag="26" ObjectIndex="3" Scale9Width="825" Scale9Height="110" ctype="ImageViewObjectData">
                <Position X="25.0000" Y="495.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <AnchorPoint />
                <CColor A="255" R="255" G="255" B="255" />
                <Size X="825.0000" Y="110.0000" />
                <PrePosition X="0.0250" Y="0.7984" />
                <PreSize X="0.0000" Y="0.0000" />
                <Children>
                  <NodeObjectData Name="bitmap_level" ActionTag="-1261768510" FrameEvent="" Tag="28" ObjectIndex="1" LabelText="Level 1" ctype="TextBMFontObjectData">
                    <Position X="400.0000" Y="10.0000" />
                    <Scale ScaleX="2.2000" ScaleY="2.2000" />
                    <AnchorPoint />
                    <CColor A="255" R="255" G="255" B="255" />
                    <Size X="82.0000" Y="36.0000" />
                    <PrePosition X="0.4848" Y="0.0909" />
                    <PreSize X="0.0000" Y="0.0000" />
                    <LabelBMFontFile_CNB Type="Default" Path="Default/defaultBMFont.fnt" />
                  </NodeObjectData>
                  <NodeObjectData Name="txt_crystal_num" ActionTag="1015206607" FrameEvent="" Tag="29" ObjectIndex="1" FontSize="36" LabelText="999999" ctype="TextObjectData">
                    <Position X="130.0000" Y="25.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <AnchorPoint />
                    <CColor A="255" R="255" G="255" B="255" />
                    <Size X="108.0000" Y="36.0000" />
                    <PrePosition X="0.1576" Y="0.2273" />
                    <PreSize X="0.0000" Y="0.0000" />
                  </NodeObjectData>
                </Children>
                <FileData Type="Normal" Path="imgs/game_scene_contents/LevelInfo.png" />
              </NodeObjectData>
              <NodeObjectData Name="btn_option" ActionTag="-1649223719" FrameEvent="" Tag="27" ObjectIndex="1" TouchEnable="True" FontSize="14" ButtonText="" Scale9Width="110" Scale9Height="110" ctype="ButtonObjectData">
                <Position X="865.0000" Y="495.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <AnchorPoint />
                <CColor A="255" R="255" G="255" B="255" />
                <Size X="110.0000" Y="110.0000" />
                <PrePosition X="0.8650" Y="0.7984" />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Default" Path="Default/Button_Disable.png" />
                <PressedFileData Type="Default" Path="Default/Button_Press.png" />
                <NormalFileData Type="Normal" Path="imgs/game_scene_contents/OptionIcon.png" />
              </NodeObjectData>
              <NodeObjectData Name="rune_table" ActionTag="-1486538198" FrameEvent="" Tag="30" ObjectIndex="4" Scale9Width="250" Scale9Height="470" ctype="ImageViewObjectData">
                <Position X="25.0000" Y="15.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <AnchorPoint />
                <CColor A="255" R="255" G="255" B="255" />
                <Size X="250.0000" Y="470.0000" />
                <PrePosition X="0.0250" Y="0.0242" />
                <PreSize X="0.0000" Y="0.0000" />
                <Children>
                  <NodeObjectData Name="txt_rune_num_water" ActionTag="-934037445" FrameEvent="" Tag="31" ObjectIndex="2" FontSize="72" LabelText="99" HorizontalAlignmentType="HT_Right" VerticalAlignmentType="VT_Bottom" ctype="TextObjectData">
                    <Position X="145.0000" Y="365.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <AnchorPoint />
                    <CColor A="255" R="255" G="255" B="255" />
                    <Size X="72.0000" Y="72.0000" />
                    <PrePosition X="0.5800" Y="0.7766" />
                    <PreSize X="0.0000" Y="0.0000" />
                  </NodeObjectData>
                  <NodeObjectData Name="txt_rune_num_air" ActionTag="-1290311486" FrameEvent="" Tag="32" ObjectIndex="3" FontSize="72" LabelText="99" HorizontalAlignmentType="HT_Right" VerticalAlignmentType="VT_Bottom" ctype="TextObjectData">
                    <Position X="145.0000" Y="255.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <AnchorPoint />
                    <CColor A="255" R="255" G="255" B="255" />
                    <Size X="72.0000" Y="72.0000" />
                    <PrePosition X="0.5800" Y="0.5426" />
                    <PreSize X="0.0000" Y="0.0000" />
                  </NodeObjectData>
                  <NodeObjectData Name="txt_rune_num_earth" ActionTag="-929335929" FrameEvent="" Tag="33" ObjectIndex="4" FontSize="72" LabelText="99" HorizontalAlignmentType="HT_Right" VerticalAlignmentType="VT_Bottom" ctype="TextObjectData">
                    <Position X="145.0000" Y="145.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <AnchorPoint />
                    <CColor A="255" R="255" G="255" B="255" />
                    <Size X="72.0000" Y="72.0000" />
                    <PrePosition X="0.5800" Y="0.3085" />
                    <PreSize X="0.0000" Y="0.0000" />
                  </NodeObjectData>
                  <NodeObjectData Name="txt_rune_num_fire" ActionTag="846922763" FrameEvent="" Tag="34" ObjectIndex="5" FontSize="72" LabelText="99" HorizontalAlignmentType="HT_Right" VerticalAlignmentType="VT_Bottom" ctype="TextObjectData">
                    <Position X="145.0000" Y="35.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <AnchorPoint />
                    <CColor A="255" R="255" G="255" B="255" />
                    <Size X="72.0000" Y="72.0000" />
                    <PrePosition X="0.5800" Y="0.0745" />
                    <PreSize X="0.0000" Y="0.0000" />
                  </NodeObjectData>
                </Children>
                <FileData Type="Normal" Path="imgs/game_scene_contents/RuneTable.png" />
              </NodeObjectData>
              <NodeObjectData Name="monster" ActionTag="-1935060250" FrameEvent="" Tag="35" ObjectIndex="2" ctype="SpriteObjectData">
                <Position X="290.0000" Y="15.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <AnchorPoint />
                <CColor A="255" R="255" G="255" B="255" />
                <Size X="470.0000" Y="470.0000" />
                <PrePosition X="0.2900" Y="0.0242" />
                <PreSize X="0.0000" Y="0.0000" />
                <FileData Type="Normal" Path="imgs/game_scene_contents/MonsterTest.png" />
              </NodeObjectData>
            </Children>
            <FileData Type="Normal" Path="imgs/game_scene_contents/BattlePanel.png" />
            <SingleColor A="255" R="150" G="200" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </NodeObjectData>
          <NodeObjectData Name="panel_player_hp" ActionTag="-1189836155" FrameEvent="" Tag="36" ObjectIndex="3" TouchEnable="True" BackColorAlpha="0" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="950" Scale9Height="40" ctype="PanelObjectData">
            <Position X="65.0000" Y="1200.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <AnchorPoint />
            <CColor A="255" R="255" G="255" B="255" />
            <Size X="950.0000" Y="40.0000" />
            <PrePosition X="0.0602" Y="0.6250" />
            <PreSize X="0.8796" Y="0.0208" />
            <Children>
              <NodeObjectData Name="player_hp_frame" ActionTag="-728493360" FrameEvent="" Tag="37" ObjectIndex="5" Scale9Width="950" Scale9Height="40" ctype="ImageViewObjectData">
                <Position X="0.0000" Y="0.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <AnchorPoint />
                <CColor A="255" R="255" G="255" B="255" />
                <Size X="950.0000" Y="40.0000" />
                <PrePosition X="0.0000" Y="0.0000" />
                <PreSize X="0.0000" Y="0.0000" />
                <FileData Type="Normal" Path="imgs/game_scene_contents/PlayerHP_Up.png" />
              </NodeObjectData>
            </Children>
            <FileData Type="Normal" Path="imgs/game_scene_contents/PlayerHP_Down.png" />
            <SingleColor A="255" R="150" G="200" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </NodeObjectData>
          <NodeObjectData Name="panel_tile_matching" ActionTag="305308468" FrameEvent="" Tag="38" ObjectIndex="4" TouchEnable="True" BackColorAlpha="0" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="950" Scale9Height="930" ctype="PanelObjectData">
            <Position X="65.0000" Y="255.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <AnchorPoint />
            <CColor A="255" R="255" G="255" B="255" />
            <Size X="950.0000" Y="930.0000" />
            <PrePosition X="0.0602" Y="0.1328" />
            <PreSize X="0.8796" Y="0.4844" />
            <FileData Type="Normal" Path="imgs/game_scene_contents/TileMatchingPanel.png" />
            <SingleColor A="255" R="150" G="200" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </NodeObjectData>
          <NodeObjectData Name="panel_skill_slots" ActionTag="-508542430" FrameEvent="" Tag="39" ObjectIndex="5" TouchEnable="True" BackColorAlpha="0" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="1000" Scale9Height="200" ctype="PanelObjectData">
            <Position X="40.0000" Y="40.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <AnchorPoint />
            <CColor A="255" R="255" G="255" B="255" />
            <Size X="1000.0000" Y="200.0000" />
            <PrePosition X="0.0370" Y="0.0208" />
            <PreSize X="0.9259" Y="0.1042" />
            <Children>
              <NodeObjectData Name="node_skill_1" ActionTag="1877753077" FrameEvent="" Tag="52" ObjectIndex="1" IconVisible="True" ctype="SingleNodeObjectData">
                <Position X="25.0000" Y="15.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <AnchorPoint />
                <CColor A="255" R="255" G="255" B="255" />
                <Size X="0.0000" Y="0.0000" />
                <PrePosition X="0.0250" Y="0.0750" />
                <PreSize X="0.0000" Y="0.0000" />
              </NodeObjectData>
              <NodeObjectData Name="node_skill_2" ActionTag="-1491573264" FrameEvent="" Tag="53" ObjectIndex="2" IconVisible="True" ctype="SingleNodeObjectData">
                <Position X="220.0000" Y="15.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <AnchorPoint />
                <CColor A="255" R="255" G="255" B="255" />
                <Size X="0.0000" Y="0.0000" />
                <PrePosition X="0.2200" Y="0.0750" />
                <PreSize X="0.0000" Y="0.0000" />
              </NodeObjectData>
              <NodeObjectData Name="node_skill_3" ActionTag="1461999373" FrameEvent="" Tag="54" ObjectIndex="3" IconVisible="True" ctype="SingleNodeObjectData">
                <Position X="415.0000" Y="15.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <AnchorPoint />
                <CColor A="255" R="255" G="255" B="255" />
                <Size X="0.0000" Y="0.0000" />
                <PrePosition X="0.4150" Y="0.0750" />
                <PreSize X="0.0000" Y="0.0000" />
              </NodeObjectData>
              <NodeObjectData Name="node_skill_4" ActionTag="-77514539" FrameEvent="" Tag="55" ObjectIndex="4" IconVisible="True" ctype="SingleNodeObjectData">
                <Position X="610.0000" Y="15.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <AnchorPoint />
                <CColor A="255" R="255" G="255" B="255" />
                <Size X="0.0000" Y="0.0000" />
                <PrePosition X="0.6100" Y="0.0750" />
                <PreSize X="0.0000" Y="0.0000" />
              </NodeObjectData>
              <NodeObjectData Name="node_skill_5" ActionTag="350471500" FrameEvent="" Tag="56" ObjectIndex="5" IconVisible="True" ctype="SingleNodeObjectData">
                <Position X="805.0000" Y="15.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <AnchorPoint />
                <CColor A="255" R="255" G="255" B="255" />
                <Size X="0.0000" Y="0.0000" />
                <PrePosition X="0.8050" Y="0.0750" />
                <PreSize X="0.0000" Y="0.0000" />
              </NodeObjectData>
            </Children>
            <FileData Type="Normal" Path="imgs/game_scene_contents/SkillSlots.png" />
            <SingleColor A="255" R="150" G="200" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </NodeObjectData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameProjectFile>