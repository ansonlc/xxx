<GameProjectFile>
  <PropertyGroup Type="Scene" Name="SkillSelectScene" ID="7c70b029-b20a-4ea9-a503-ec882787cd8b" Version="2.2.6.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="1.0000" />
      <ObjectData Name="Scene" Tag="39" ctype="GameNodeObjectData">
        <Size X="1080.0000" Y="1920.0000" />
        <Children>
          <AbstractNodeData Name="Image_1" ActionTag="-559563380" Tag="40" IconVisible="False" PrePositionEnabled="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" Scale9Width="1080" Scale9Height="1920" ObjectIndex="1" ctype="ImageViewObjectData">
            <Size X="1080.0000" Y="1920.0000" />
            <AnchorPoint ScaleY="1.0000" />
            <Position X="2.0000" Y="1924.9919" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.0019" Y="1.0026" />
            <PreSize />
            <FileData Type="Normal" Path="imgs/main_menu_bg.png" Plist="" />
          </AbstractNodeData>
          <AbstractNodeData Name="SkillScroll" ActionTag="321269733" Tag="41" Alpha="190" IconVisible="False" PrePositionEnabled="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" PreSizeEnable="True" TouchEnable="True" ClipAble="True" BackColorAlpha="102" ComboBoxIndex="1" ColorAngle="90.0000" IsBounceEnabled="True" ScrollDirectionType="Vertical" ObjectIndex="1" ctype="ScrollViewObjectData">
            <Size X="864.0000" Y="1152.0000" />
            <AnchorPoint ScaleY="1.0000" />
            <Position X="109.1581" Y="1424.2023" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.1011" Y="0.7418" />
            <PreSize X="0.8000" Y="0.6000" />
            <SingleColor A="255" R="255" G="150" B="100" />
            <FirstColor A="255" R="255" G="150" B="100" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
            <InnerNodeSize Width="864" Height="2600" />
          </AbstractNodeData>
          <AbstractNodeData Name="Image_SkillSlots" ActionTag="1959469483" Tag="42" IconVisible="False" Scale9Width="1000" Scale9Height="200" ObjectIndex="2" ctype="ImageViewObjectData">
            <Size X="1000.0000" Y="200.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="542.4991" Y="1652.4724" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5023" Y="0.8607" />
            <PreSize />
            <FileData Type="Normal" Path="imgs/game_scene_contents/SkillSlots.png" Plist="" />
          </AbstractNodeData>
          <AbstractNodeData Name="Button_Ok" ActionTag="1058655525" Tag="6" IconVisible="False" TouchEnable="True" FontSize="14" ButtonText="Ok" Scale9Width="46" Scale9Height="36" ObjectIndex="1" ctype="ButtonObjectData">
            <Size X="46.0000" Y="36.0000" />
            <AnchorPoint ScaleY="1.0000" />
            <Position X="160.8184" Y="224.0011" />
            <Scale ScaleX="6.6956" ScaleY="1.8889" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.1489" Y="0.1167" />
            <PreSize />
            <TextColor A="255" R="65" G="65" B="70" />
            <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
            <PressedFileData Type="Default" Path="Default/Button_Press.png" Plist="" />
            <NormalFileData Type="Default" Path="Default/Button_Normal.png" Plist="" />
          </AbstractNodeData>
          <AbstractNodeData Name="Button_Cancel" ActionTag="1660194804" Tag="7" IconVisible="False" TouchEnable="True" FontSize="14" ButtonText="Cancel" Scale9Width="46" Scale9Height="36" ObjectIndex="2" ctype="ButtonObjectData">
            <Size X="46.0000" Y="36.0000" />
            <AnchorPoint ScaleY="1.0000" />
            <Position X="590.1497" Y="230.0011" />
            <Scale ScaleX="6.6956" ScaleY="1.8889" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5464" Y="0.1198" />
            <PreSize />
            <TextColor A="255" R="65" G="65" B="70" />
            <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
            <PressedFileData Type="Default" Path="Default/Button_Press.png" Plist="" />
            <NormalFileData Type="Default" Path="Default/Button_Normal.png" Plist="" />
          </AbstractNodeData>
          <AbstractNodeData Name="Button_Skill1" ActionTag="132889404" Tag="8" IconVisible="False" TouchEnable="True" FontSize="14" Scale9Width="46" Scale9Height="36" ObjectIndex="3" ctype="ButtonObjectData">
            <Size X="46.0000" Y="36.0000" />
            <AnchorPoint ScaleY="1.0000" />
            <Position X="75.1653" Y="1733.8228" />
            <Scale ScaleX="3.3043" ScaleY="4.4444" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.0696" Y="0.9030" />
            <PreSize />
            <TextColor A="255" R="65" G="65" B="70" />
            <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
            <PressedFileData Type="Default" Path="Default/Button_Press.png" Plist="" />
            <NormalFileData Type="Default" Path="Default/Button_Normal.png" Plist="" />
          </AbstractNodeData>
          <AbstractNodeData Name="Button_Skill2" ActionTag="172380319" Tag="9" IconVisible="False" TouchEnable="True" FontSize="14" Scale9Width="46" Scale9Height="36" ObjectIndex="4" ctype="ButtonObjectData">
            <Size X="46.0000" Y="36.0000" />
            <AnchorPoint ScaleY="1.0000" />
            <Position X="271.1653" Y="1731.8192" />
            <Scale ScaleX="3.3478" ScaleY="4.3889" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.2511" Y="0.9020" />
            <PreSize />
            <TextColor A="255" R="65" G="65" B="70" />
            <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
            <PressedFileData Type="Default" Path="Default/Button_Press.png" Plist="" />
            <NormalFileData Type="Default" Path="Default/Button_Normal.png" Plist="" />
          </AbstractNodeData>
          <AbstractNodeData Name="Button_Skill3" ActionTag="82591050" Tag="10" IconVisible="False" TouchEnable="True" FontSize="14" Scale9Width="46" Scale9Height="36" ObjectIndex="5" ctype="ButtonObjectData">
            <Size X="46.0000" Y="36.0000" />
            <AnchorPoint ScaleY="1.0000" />
            <Position X="467.1667" Y="1729.8223" />
            <Scale ScaleX="3.3043" ScaleY="4.2222" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.4326" Y="0.9009" />
            <PreSize />
            <TextColor A="255" R="65" G="65" B="70" />
            <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
            <PressedFileData Type="Default" Path="Default/Button_Press.png" Plist="" />
            <NormalFileData Type="Default" Path="Default/Button_Normal.png" Plist="" />
          </AbstractNodeData>
          <AbstractNodeData Name="Button_Skill4" ActionTag="1543723005" Tag="11" IconVisible="False" TouchEnable="True" FontSize="14" Scale9Width="46" Scale9Height="36" ObjectIndex="6" ctype="ButtonObjectData">
            <Size X="46.0000" Y="36.0000" />
            <AnchorPoint ScaleY="1.0000" />
            <Position X="663.1696" Y="1729.8228" />
            <Scale ScaleX="3.2174" ScaleY="4.2222" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.6140" Y="0.9009" />
            <PreSize />
            <TextColor A="255" R="65" G="65" B="70" />
            <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
            <PressedFileData Type="Default" Path="Default/Button_Press.png" Plist="" />
            <NormalFileData Type="Default" Path="Default/Button_Normal.png" Plist="" />
          </AbstractNodeData>
          <AbstractNodeData Name="Button_Skill5" ActionTag="-1579383830" Tag="12" IconVisible="False" TouchEnable="True" FontSize="14" Scale9Width="46" Scale9Height="36" ObjectIndex="7" ctype="ButtonObjectData">
            <Size X="46.0000" Y="36.0000" />
            <AnchorPoint ScaleY="1.0000" />
            <Position X="858.1711" Y="1727.8225" />
            <Scale ScaleX="3.2174" ScaleY="4.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.7946" Y="0.8999" />
            <PreSize />
            <TextColor A="255" R="65" G="65" B="70" />
            <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
            <PressedFileData Type="Default" Path="Default/Button_Press.png" Plist="" />
            <NormalFileData Type="Default" Path="Default/Button_Normal.png" Plist="" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameProjectFile>