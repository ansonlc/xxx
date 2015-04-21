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
          <NodeObjectData Name="ButtonReturn" ActionTag="500458427" FrameEvent="" Tag="19" ObjectIndex="2" TouchEnable="True" FontSize="14" ButtonText="Button" Scale9Width="200" Scale9Height="200" ctype="ButtonObjectData">
            <Position X="991.4963" Y="1825.3320" />
            <Scale ScaleX="0.4615" ScaleY="0.4615" />
            <AnchorPoint ScaleX="0.5109" ScaleY="0.4372" />
            <CColor A="255" R="255" G="255" B="255" />
            <Size X="200.0000" Y="200.0000" />
            <PrePosition X="0.9181" Y="0.9507" />
            <PreSize X="0.0000" Y="0.0000" />
            <TextColor A="255" R="65" G="65" B="70" />
            <DisabledFileData Type="Default" Path="Default/Button_Disable.png" />
            <PressedFileData Type="Normal" Path="imgs/btns/icon/icon_return_press.png" />
            <NormalFileData Type="Normal" Path="imgs/btns/icon/icon_return.png" />
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
          <NodeObjectData Name="UpgradePanel" ActionTag="-1654028597" FrameEvent="" Tag="64" ObjectIndex="5" TouchEnable="True" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="398" Scale9Height="192" ctype="PanelObjectData">
            <Position X="143.4997" Y="704.9978" />
            <Scale ScaleX="2.0250" ScaleY="2.0417" />
            <AnchorPoint />
            <CColor A="255" R="255" G="255" B="255" />
            <Size X="398.0000" Y="192.0000" />
            <PrePosition X="0.1329" Y="0.3672" />
            <PreSize X="0.3685" Y="0.1280" />
            <Children>
              <NodeObjectData Name="plus100" ActionTag="177976852" FrameEvent="" Tag="65" ObjectIndex="4" TouchEnable="True" FontSize="14" ButtonText="" Scale9Width="46" Scale9Height="36" ctype="ButtonObjectData">
                <Position X="83.4585" Y="92.7373" />
                <Scale ScaleX="0.6000" ScaleY="0.6000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <CColor A="255" R="255" G="255" B="255" />
                <Size X="46.0000" Y="36.0000" />
                <PrePosition X="0.2097" Y="0.4830" />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Default" Path="Default/Button_Disable.png" />
                <PressedFileData Type="Default" Path="Default/Button_Press.png" />
                <NormalFileData Type="Default" Path="Default/Button_Normal.png" />
              </NodeObjectData>
              <NodeObjectData Name="plus10" ActionTag="1382228106" FrameEvent="" Tag="66" ObjectIndex="5" TouchEnable="True" FontSize="14" ButtonText="" Scale9Width="46" Scale9Height="36" ctype="ButtonObjectData">
                <Position X="198.1900" Y="91.1040" />
                <Scale ScaleX="0.6000" ScaleY="0.6000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <CColor A="255" R="255" G="255" B="255" />
                <Size X="46.0000" Y="36.0000" />
                <PrePosition X="0.4980" Y="0.4745" />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Default" Path="Default/Button_Disable.png" />
                <PressedFileData Type="Default" Path="Default/Button_Press.png" />
                <NormalFileData Type="Default" Path="Default/Button_Normal.png" />
              </NodeObjectData>
              <NodeObjectData Name="plus1" ActionTag="1062266895" FrameEvent="" Tag="67" ObjectIndex="6" TouchEnable="True" FontSize="14" ButtonText="" Scale9Width="46" Scale9Height="36" ctype="ButtonObjectData">
                <Position X="313.4161" Y="91.1038" />
                <Scale ScaleX="0.6000" ScaleY="0.6000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <CColor A="255" R="255" G="255" B="255" />
                <Size X="46.0000" Y="36.0000" />
                <PrePosition X="0.7875" Y="0.4745" />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Default" Path="Default/Button_Disable.png" />
                <PressedFileData Type="Default" Path="Default/Button_Press.png" />
                <NormalFileData Type="Default" Path="Default/Button_Normal.png" />
              </NodeObjectData>
              <NodeObjectData Name="confirm" ActionTag="122558006" FrameEvent="" Tag="68" ObjectIndex="7" TouchEnable="True" FontSize="14" ButtonText="" Scale9Width="46" Scale9Height="36" ctype="ButtonObjectData">
                <Position X="110.5348" Y="37.3893" />
                <Scale ScaleX="1.0000" ScaleY="0.5500" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <CColor A="255" R="255" G="255" B="255" />
                <Size X="46.0000" Y="36.0000" />
                <PrePosition X="0.2777" Y="0.1947" />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Default" Path="Default/Button_Disable.png" />
                <PressedFileData Type="Default" Path="Default/Button_Press.png" />
                <NormalFileData Type="Default" Path="Default/Button_Normal.png" />
              </NodeObjectData>
              <NodeObjectData Name="cancel" ActionTag="1301994066" FrameEvent="" Tag="69" ObjectIndex="8" TouchEnable="True" FontSize="14" ButtonText="" Scale9Width="46" Scale9Height="36" ctype="ButtonObjectData">
                <Position X="286.8308" Y="36.4097" />
                <Scale ScaleX="1.0000" ScaleY="0.5500" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <CColor A="255" R="255" G="255" B="255" />
                <Size X="46.0000" Y="36.0000" />
                <PrePosition X="0.7207" Y="0.1896" />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Default" Path="Default/Button_Disable.png" />
                <PressedFileData Type="Default" Path="Default/Button_Press.png" />
                <NormalFileData Type="Default" Path="Default/Button_Normal.png" />
              </NodeObjectData>
              <NodeObjectData Name="display" ActionTag="1795713424" FrameEvent="" Tag="70" ObjectIndex="7" FontSize="20" LabelText="Use 4500 Crystal to Lv.09 + 32%" ctype="TextObjectData">
                <Position X="198.1914" Y="150.2883" />
                <Scale ScaleX="0.9270" ScaleY="1.0710" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <CColor A="255" R="255" G="0" B="0" />
                <Size X="292.0000" Y="23.0000" />
                <PrePosition X="0.4980" Y="0.7828" />
                <PreSize X="0.0000" Y="0.0000" />
              </NodeObjectData>
            </Children>
            <SingleColor A="255" R="255" G="255" B="255" />
            <FirstColor A="255" R="255" G="255" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </NodeObjectData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameProjectFile>