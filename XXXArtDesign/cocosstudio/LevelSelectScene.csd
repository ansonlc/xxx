<GameProjectFile>
  <PropertyGroup Type="Scene" Name="LevelSelectScene" ID="15ac7223-e995-4f95-a5d5-c90fa249a55d" Version="2.2.6.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="1.0000" />
      <ObjectData Name="Scene" ctype="GameNodeObjectData">
        <Size X="1080.0000" Y="1920.0000" />
        <Children>
          <AbstractNodeData Name="main_menu_bg" ActionTag="240643451" Tag="37" IconVisible="False" PrePositionEnabled="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" ObjectIndex="1" ctype="SpriteObjectData">
            <Size X="1080.0000" Y="1920.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="540.0000" Y="960.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="0.5000" />
            <PreSize />
            <FileData Type="Normal" Path="imgs/main_menu_bg.png" Plist="" />
          </AbstractNodeData>
          <AbstractNodeData Name="LevelScroll" ActionTag="-1172032880" Tag="4" IconVisible="False" PrePositionEnabled="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" PreSizeEnable="True" TouchEnable="True" ClipAble="True" BackColorAlpha="110" ColorAngle="90.0000" Scale9Width="400" Scale9Height="15960" ScrollDirectionType="Vertical" ObjectIndex="1" ctype="ScrollViewObjectData">
            <Size X="1080.0000" Y="1536.0000" />
            <Children>
              <AbstractNodeData Name="txt_hidden" ActionTag="-503738617" CallBackType="Touch" Tag="6" IconVisible="False" PrePositionEnabled="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" TouchEnable="True" FontSize="72" LabelText="A Hidden Level" ObjectIndex="3" ctype="TextObjectData">
                <Size X="504.0000" Y="72.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="540.0000" Y="1596.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.1000" />
                <PreSize />
              </AbstractNodeData>
              <AbstractNodeData Name="bg_level" ActionTag="295042606" Tag="486" IconVisible="False" ObjectIndex="284" ctype="SpriteObjectData">
                <Size X="400.0000" Y="15960.0000" />
                <AnchorPoint />
                <Position />
                <Scale ScaleX="2.7500" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize />
                <FileData Type="Normal" Path="imgs/bg_level.jpg" Plist="" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize X="1.0000" Y="0.8000" />
            <SingleColor A="255" R="58" G="165" B="255" />
            <FirstColor A="255" R="58" G="165" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
            <InnerNodeSize Width="1080" Height="15960" />
          </AbstractNodeData>
          <AbstractNodeData Name="node_rtn_btn" ActionTag="-827736537" Tag="169" IconVisible="True" ObjectIndex="1" ctype="SingleNodeObjectData">
            <Size />
            <AnchorPoint />
            <Position X="940.0000" Y="1820.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.8704" Y="0.9479" />
            <PreSize />
          </AbstractNodeData>
          <AbstractNodeData Name="TitleText" ActionTag="-1002433260" Tag="3" IconVisible="False" PrePositionEnabled="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" FontSize="100" LabelText="Level Select" HorizontalAlignmentType="HT_Center" ObjectIndex="1" ctype="TextObjectData">
            <Size X="600.0000" Y="100.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="540.0000" Y="1728.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="0.9000" />
            <PreSize />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameProjectFile>