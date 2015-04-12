<GameProjectFile>
  <PropertyGroup Type="Scene" Name="SkillTree" ID="b317f116-a615-41ca-af73-3f27eadb5a7d" Version="2.0.5.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="1.0000" />
      <ObjectData Name="Scene" FrameEvent="" Tag="256" ctype="SingleNodeObjectData">
        <Position X="0.0000" Y="0.0000" />
        <Scale ScaleX="1.0000" ScaleY="1.0000" />
        <AnchorPoint />
        <CColor A="255" R="255" G="255" B="255" />
        <Size X="1080.0000" Y="1920.0000" />
        <PrePosition X="0.0000" Y="0.0000" />
        <PreSize X="0.0000" Y="0.0000" />
        <Children>
          <NodeObjectData Name="Image_1" ActionTag="-1807929310" FrameEvent="" Tag="415" ObjectIndex="1" Scale9Width="1080" Scale9Height="1920" ctype="ImageViewObjectData">
            <Position X="0.0000" Y="0.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <AnchorPoint />
            <CColor A="255" R="255" G="255" B="255" />
            <Size X="1080.0000" Y="1920.0000" />
            <PrePosition X="0.0000" Y="0.0000" />
            <PreSize X="0.0000" Y="0.0000" />
            <FileData Type="Normal" Path="imgs/main_menu_bg.png" />
          </NodeObjectData>
          <NodeObjectData Name="ScrollView_1" ActionTag="503153752" FrameEvent="" Tag="416" ObjectIndex="1" TouchEnable="True" ClipAble="True" BackColorAlpha="102" ComboBoxIndex="1" ColorAngle="90.0000" IsBounceEnabled="True" ScrollDirectionType="Vertical" ctype="ScrollViewObjectData">
            <Position X="0.0000" Y="400.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <AnchorPoint />
            <CColor A="255" R="255" G="255" B="255" />
            <Size X="1080.0000" Y="1260.0000" />
            <PrePosition X="0.0000" Y="0.2083" />
            <PreSize X="1.0000" Y="0.6563" />
            <SingleColor A="255" R="255" G="255" B="255" />
            <FirstColor A="255" R="255" G="255" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
            <InnerNodeSize Width="1080" Height="1500" />
          </NodeObjectData>
          <NodeObjectData Name="Image_2" ActionTag="132262724" FrameEvent="" Tag="417" ObjectIndex="2" Scale9Width="1080" Scale9Height="255" ctype="ImageViewObjectData">
            <Position X="542.9999" Y="1784.9987" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <CColor A="255" R="255" G="255" B="255" />
            <Size X="1080.0000" Y="255.0000" />
            <PrePosition X="0.5028" Y="0.9297" />
            <PreSize X="0.0000" Y="0.0000" />
            <FileData Type="Normal" Path="imgs/SkillTree/Header.png" />
          </NodeObjectData>
          <NodeObjectData Name="Image_4" ActionTag="-1299158466" FrameEvent="" Tag="419" ObjectIndex="4" Scale9Width="1080" Scale9Height="410" ctype="ImageViewObjectData">
            <Position X="0.0000" Y="0.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <AnchorPoint />
            <CColor A="255" R="255" G="255" B="255" />
            <Size X="1080.0000" Y="410.0000" />
            <PrePosition X="0.0000" Y="0.0000" />
            <PreSize X="0.0000" Y="0.0000" />
            <FileData Type="Normal" Path="imgs/SkillTree/Foot.png" />
          </NodeObjectData>
          <NodeObjectData Name="Button_1" ActionTag="1332457478" FrameEvent="" Tag="420" ObjectIndex="1" TouchEnable="True" FontSize="14" ButtonText="" Scale9Width="150" Scale9Height="60" ctype="ButtonObjectData">
            <Position X="148.6653" Y="119.0000" />
            <Scale ScaleX="1.2889" ScaleY="1.1667" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <CColor A="255" R="255" G="255" B="255" />
            <Size X="150.0000" Y="60.0000" />
            <PrePosition X="0.1377" Y="0.0620" />
            <PreSize X="0.0000" Y="0.0000" />
            <TextColor A="255" R="65" G="65" B="70" />
            <DisabledFileData Type="Default" Path="Default/Button_Disable.png" />
            <PressedFileData Type="Normal" Path="imgs/SkillTree/Btn_Upgrade_press.png" />
            <NormalFileData Type="Normal" Path="imgs/SkillTree/Btn_Upgrade.png" />
          </NodeObjectData>
          <NodeObjectData Name="ButtonReturn" ActionTag="500458427" FrameEvent="" Tag="19" ObjectIndex="2" TouchEnable="True" FontSize="14" ButtonText="Button" Scale9Width="110" Scale9Height="110" ctype="ButtonObjectData">
            <Position X="1025.9755" Y="1787.1311" />
            <Scale ScaleX="0.7000" ScaleY="0.7000" />
            <AnchorPoint ScaleX="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <Size X="110.0000" Y="110.0000" />
            <PrePosition X="0.9500" Y="0.9308" />
            <PreSize X="0.0000" Y="0.0000" />
            <TextColor A="255" R="65" G="65" B="70" />
            <DisabledFileData Type="Default" Path="Default/Button_Disable.png" />
            <PressedFileData Type="Normal" Path="imgs/btns/icon/icon_Close_press.png" />
            <NormalFileData Type="Normal" Path="imgs/btns/icon/icon_Close.png" />
          </NodeObjectData>
          <NodeObjectData Name="CrystalNumDisplay" ActionTag="-234263723" FrameEvent="" Tag="22" ObjectIndex="1" FontSize="20" LabelText="999999&#xA;" ctype="TextObjectData">
            <Position X="163.8811" Y="1855.0077" />
            <Scale ScaleX="2.7407" ScaleY="2.5942" />
            <AnchorPoint ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <Size X="66.0000" Y="46.0000" />
            <PrePosition X="0.1517" Y="0.9661" />
            <PreSize X="0.0000" Y="0.0000" />
          </NodeObjectData>
          <NodeObjectData Name="ScrollView_2" ActionTag="1888238357" FrameEvent="" Tag="10" ObjectIndex="2" TouchEnable="True" ClipAble="True" BackColorAlpha="102" ComboBoxIndex="1" ColorAngle="90.0000" IsBounceEnabled="True" ScrollDirectionType="Vertical" ctype="ScrollViewObjectData">
            <Position X="0.0000" Y="400.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <AnchorPoint />
            <CColor A="255" R="255" G="255" B="255" />
            <Size X="1080.0000" Y="1260.0000" />
            <PrePosition X="0.0000" Y="0.2083" />
            <PreSize X="0.0000" Y="0.0000" />
            <SingleColor A="255" R="255" G="255" B="255" />
            <FirstColor A="255" R="255" G="255" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
            <InnerNodeSize Width="1080" Height="1500" />
          </NodeObjectData>
          <NodeObjectData Name="ScrollView_3" ActionTag="-1538551366" FrameEvent="" Tag="11" ObjectIndex="3" TouchEnable="True" ClipAble="True" BackColorAlpha="102" ComboBoxIndex="1" ColorAngle="90.0000" IsBounceEnabled="True" ScrollDirectionType="Vertical" ctype="ScrollViewObjectData">
            <Position X="0.0000" Y="400.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <AnchorPoint />
            <CColor A="255" R="255" G="255" B="255" />
            <Size X="1080.0000" Y="1260.0000" />
            <PrePosition X="0.0000" Y="0.2083" />
            <PreSize X="0.0000" Y="0.0000" />
            <SingleColor A="255" R="255" G="255" B="255" />
            <FirstColor A="255" R="255" G="255" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
            <InnerNodeSize Width="1080" Height="1500" />
          </NodeObjectData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameProjectFile>