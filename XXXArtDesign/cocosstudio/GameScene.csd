<GameProjectFile>
  <PropertyGroup Type="Scene" Name="GameScene" ID="d9e0d6ba-66e7-4e7a-ae42-ba4e0ccac61e" Version="2.2.8.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="1.0000" />
      <ObjectData Name="Scene" Tag="20" ctype="GameNodeObjectData">
        <Size X="1080.0000" Y="1920.0000" />
        <Children>
          <AbstractNodeData Name="main_menu_bg" ActionTag="1183218263" Tag="21" IconVisible="False" ObjectIndex="1" ctype="SpriteObjectData">
            <Size X="1080.0000" Y="1920.0000" />
            <AnchorPoint />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize />
            <FileData Type="Normal" Path="imgs/main_menu_bg.png" Plist="" />
          </AbstractNodeData>
          <AbstractNodeData Name="panel_battle" ActionTag="1777186065" Tag="22" IconVisible="False" TouchEnable="True" BackColorAlpha="0" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="1000" Scale9Height="620" ObjectIndex="1" ctype="PanelObjectData">
            <Size X="1000.0000" Y="620.0000" />
            <Children>
              <AbstractNodeData Name="level_info" ActionTag="1812552024" Tag="26" IconVisible="False" Scale9Width="825" Scale9Height="110" ObjectIndex="3" ctype="ImageViewObjectData">
                <Size X="825.0000" Y="110.0000" />
                <Children>
                  <AbstractNodeData Name="bitmap_level" ActionTag="-1261768510" Tag="28" IconVisible="False" LabelText="Level 1" ObjectIndex="1" ctype="TextBMFontObjectData">
                    <Size X="82.0000" Y="36.0000" />
                    <AnchorPoint />
                    <Position X="400.0000" Y="10.0000" />
                    <Scale ScaleX="2.2000" ScaleY="2.2000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.4848" Y="0.0909" />
                    <PreSize />
                    <LabelBMFontFile_CNB Type="Default" Path="Default/defaultBMFont.fnt" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="txt_crystal_num" ActionTag="1015206607" Tag="29" IconVisible="False" FontSize="36" LabelText="999999" ObjectIndex="1" ctype="TextObjectData">
                    <Size X="108.0000" Y="36.0000" />
                    <AnchorPoint />
                    <Position X="130.0000" Y="25.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.1576" Y="0.2273" />
                    <PreSize />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="25.0000" Y="495.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.0250" Y="0.7984" />
                <PreSize />
                <FileData Type="Normal" Path="imgs/game_scene_contents/LevelInfo.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_option" ActionTag="-1649223719" Tag="27" IconVisible="False" TouchEnable="True" FontSize="14" Scale9Width="110" Scale9Height="110" ObjectIndex="1" ctype="ButtonObjectData">
                <Size X="110.0000" Y="110.0000" />
                <AnchorPoint />
                <Position X="865.0000" Y="495.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.8650" Y="0.7984" />
                <PreSize />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
                <PressedFileData Type="Default" Path="Default/Button_Press.png" Plist="" />
                <NormalFileData Type="Normal" Path="imgs/game_scene_contents/OptionIcon.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="rune_table" ActionTag="-1486538198" Tag="30" IconVisible="False" Scale9Width="250" Scale9Height="470" ObjectIndex="4" ctype="ImageViewObjectData">
                <Size X="250.0000" Y="470.0000" />
                <Children>
                  <AbstractNodeData Name="txt_rune_num_water" ActionTag="-934037445" Tag="31" IconVisible="False" FontSize="72" LabelText="99" HorizontalAlignmentType="HT_Right" VerticalAlignmentType="VT_Bottom" ObjectIndex="2" ctype="TextObjectData">
                    <Size X="72.0000" Y="72.0000" />
                    <AnchorPoint />
                    <Position X="145.0000" Y="365.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5800" Y="0.7766" />
                    <PreSize />
                  </AbstractNodeData>
                  <AbstractNodeData Name="txt_rune_num_air" ActionTag="-1290311486" Tag="32" IconVisible="False" FontSize="72" LabelText="99" HorizontalAlignmentType="HT_Right" VerticalAlignmentType="VT_Bottom" ObjectIndex="3" ctype="TextObjectData">
                    <Size X="72.0000" Y="72.0000" />
                    <AnchorPoint />
                    <Position X="145.0000" Y="255.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5800" Y="0.5426" />
                    <PreSize />
                  </AbstractNodeData>
                  <AbstractNodeData Name="txt_rune_num_earth" ActionTag="-929335929" Tag="33" IconVisible="False" FontSize="72" LabelText="99" HorizontalAlignmentType="HT_Right" VerticalAlignmentType="VT_Bottom" ObjectIndex="4" ctype="TextObjectData">
                    <Size X="72.0000" Y="72.0000" />
                    <AnchorPoint />
                    <Position X="145.0000" Y="145.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5800" Y="0.3085" />
                    <PreSize />
                  </AbstractNodeData>
                  <AbstractNodeData Name="txt_rune_num_fire" ActionTag="846922763" Tag="34" IconVisible="False" FontSize="72" LabelText="99" HorizontalAlignmentType="HT_Right" VerticalAlignmentType="VT_Bottom" ObjectIndex="5" ctype="TextObjectData">
                    <Size X="72.0000" Y="72.0000" />
                    <AnchorPoint />
                    <Position X="145.0000" Y="35.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5800" Y="0.0745" />
                    <PreSize />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="25.0000" Y="15.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.0250" Y="0.0242" />
                <PreSize />
                <FileData Type="Normal" Path="imgs/game_scene_contents/RuneTable.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="monster" ActionTag="-1935060250" Tag="35" IconVisible="False" ObjectIndex="2" ctype="SpriteObjectData">
                <Size X="470.0000" Y="470.0000" />
                <AnchorPoint />
                <Position X="290.0000" Y="15.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.2900" Y="0.0242" />
                <PreSize />
                <FileData Type="Normal" Path="imgs/game_scene_contents/MonsterTest.png" Plist="" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint />
            <Position X="40.0000" Y="1265.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.0370" Y="0.6589" />
            <PreSize X="0.9259" Y="0.3229" />
            <FileData Type="Normal" Path="imgs/game_scene_contents/BattlePanel.png" Plist="" />
            <SingleColor A="255" R="150" G="200" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="panel_player_hp" ActionTag="-1189836155" Tag="36" IconVisible="False" TouchEnable="True" BackColorAlpha="0" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="950" Scale9Height="40" ObjectIndex="3" ctype="PanelObjectData">
            <Size X="950.0000" Y="40.0000" />
            <Children>
              <AbstractNodeData Name="player_hp_frame" ActionTag="-728493360" Tag="37" IconVisible="False" Scale9Width="950" Scale9Height="40" ObjectIndex="5" ctype="ImageViewObjectData">
                <Size X="950.0000" Y="40.0000" />
                <AnchorPoint />
                <Position />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize />
                <FileData Type="Normal" Path="imgs/game_scene_contents/PlayerHP_Up.png" Plist="" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint />
            <Position X="65.0000" Y="1200.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.0602" Y="0.6250" />
            <PreSize X="0.8796" Y="0.0208" />
            <FileData Type="Normal" Path="imgs/game_scene_contents/PlayerHP_Down.png" Plist="" />
            <SingleColor A="255" R="150" G="200" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="panel_tile_matching" ActionTag="305308468" Tag="38" IconVisible="False" TouchEnable="True" BackColorAlpha="0" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="950" Scale9Height="930" ObjectIndex="4" ctype="PanelObjectData">
            <Size X="950.0000" Y="930.0000" />
            <AnchorPoint />
            <Position X="65.0000" Y="255.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.0602" Y="0.1328" />
            <PreSize X="0.8796" Y="0.4844" />
            <FileData Type="Normal" Path="imgs/game_scene_contents/TileMatchingPanel.png" Plist="" />
            <SingleColor A="255" R="150" G="200" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="panel_skill_slots" ActionTag="-508542430" Tag="39" IconVisible="False" TouchEnable="True" BackColorAlpha="0" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="1000" Scale9Height="200" ObjectIndex="5" ctype="PanelObjectData">
            <Size X="1000.0000" Y="200.0000" />
            <Children>
              <AbstractNodeData Name="node_skill_1" ActionTag="1877753077" Tag="52" IconVisible="True" ObjectIndex="1" ctype="SingleNodeObjectData">
                <Size />
                <AnchorPoint />
                <Position X="25.0000" Y="15.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.0250" Y="0.0750" />
                <PreSize />
              </AbstractNodeData>
              <AbstractNodeData Name="node_skill_2" ActionTag="-1491573264" Tag="53" IconVisible="True" ObjectIndex="2" ctype="SingleNodeObjectData">
                <Size />
                <AnchorPoint />
                <Position X="220.0000" Y="15.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.2200" Y="0.0750" />
                <PreSize />
              </AbstractNodeData>
              <AbstractNodeData Name="node_skill_3" ActionTag="1461999373" Tag="54" IconVisible="True" ObjectIndex="3" ctype="SingleNodeObjectData">
                <Size />
                <AnchorPoint />
                <Position X="415.0000" Y="15.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4150" Y="0.0750" />
                <PreSize />
              </AbstractNodeData>
              <AbstractNodeData Name="node_skill_4" ActionTag="-77514539" Tag="55" IconVisible="True" ObjectIndex="4" ctype="SingleNodeObjectData">
                <Size />
                <AnchorPoint />
                <Position X="610.0000" Y="15.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.6100" Y="0.0750" />
                <PreSize />
              </AbstractNodeData>
              <AbstractNodeData Name="node_skill_5" ActionTag="350471500" Tag="56" IconVisible="True" ObjectIndex="5" ctype="SingleNodeObjectData">
                <Size />
                <AnchorPoint />
                <Position X="805.0000" Y="15.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.8050" Y="0.0750" />
                <PreSize />
              </AbstractNodeData>
            </Children>
            <AnchorPoint />
            <Position X="40.0000" Y="40.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.0370" Y="0.0208" />
            <PreSize X="0.9259" Y="0.1042" />
            <FileData Type="Normal" Path="imgs/game_scene_contents/SkillSlots.png" Plist="" />
            <SingleColor A="255" R="150" G="200" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameProjectFile>