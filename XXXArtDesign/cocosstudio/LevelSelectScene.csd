<GameProjectFile>
  <PropertyGroup Type="Scene" Name="LevelSelectScene" ID="15ac7223-e995-4f95-a5d5-c90fa249a55d" Version="2.0.5.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="1.0000" />
      <ObjectData Name="Scene" FrameEvent="" ctype="SingleNodeObjectData">
        <Position X="0.0000" Y="0.0000" />
        <Scale ScaleX="1.0000" ScaleY="1.0000" />
        <AnchorPoint />
        <CColor A="255" R="255" G="255" B="255" />
        <Size X="1080.0000" Y="1920.0000" />
        <PrePosition X="0.0000" Y="0.0000" />
        <PreSize X="0.0000" Y="0.0000" />
        <Children>
          <NodeObjectData Name="TitleText" ActionTag="-1002433260" FrameEvent="" Tag="3" ObjectIndex="1" PrePositionEnabled="True" FontSize="20" LabelText="Level Select" HorizontalAlignmentType="HT_Center" ctype="TextObjectData">
            <Position X="540.0000" Y="1728.0000" />
            <Scale ScaleX="6.0000" ScaleY="6.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <CColor A="255" R="255" G="255" B="255" />
            <Size X="120.0000" Y="20.0000" />
            <PrePosition X="0.5000" Y="0.9000" />
            <PreSize X="0.0000" Y="0.0000" />
          </NodeObjectData>
          <NodeObjectData Name="LevelScroll" ActionTag="-1172032880" FrameEvent="" Tag="4" ObjectIndex="1" PrePositionEnabled="True" PreSizeEnable="True" TouchEnable="True" ClipAble="True" BackColorAlpha="110" ComboBoxIndex="2" ColorAngle="90.0000" ScrollDirectionType="Vertical" IsBounceEnabled="True" ctype="ScrollViewObjectData">
            <Position X="0.0000" Y="1535.9999" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <AnchorPoint ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <Size X="1080.0000" Y="1536.0000" />
            <PrePosition X="0.0000" Y="0.8000" />
            <PreSize X="1.0000" Y="0.8000" />
            <Children>
              <NodeObjectData Name="txt_hidden" ActionTag="-503738617" FrameEvent="" CallBackType="Touch" Tag="6" ObjectIndex="3" PrePositionEnabled="True" TouchEnable="True" FontSize="72" LabelText="A Hidden Level" ctype="TextObjectData">
                <Position X="539.9988" Y="192.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <CColor A="255" R="255" G="255" B="255" />
                <Size X="504.0000" Y="72.0000" />
                <PrePosition X="0.5000" Y="0.1000" />
                <PreSize X="0.0000" Y="0.0000" />
              </NodeObjectData>
              <NodeObjectData Name="btn_lvl_1" ActionTag="2112080493" FrameEvent="" Tag="7" ObjectIndex="1" PrePositionEnabled="True" TouchEnable="True" FontSize="72" ButtonText="Level 1" Scale9Width="46" Scale9Height="36" ctype="ButtonObjectData">
                <Position X="539.9867" Y="1728.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <CColor A="255" R="255" G="255" B="255" />
                <Size X="274.0000" Y="95.0000" />
                <PrePosition X="0.5000" Y="0.9000" />
                <PreSize X="0.0000" Y="0.0000" />
                <FontResource Type="Normal" Path="fonts/ALGER.TTF" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Default" Path="Default/Button_Disable.png" />
                <PressedFileData Type="Default" Path="Default/Button_Press.png" />
                <NormalFileData Type="Default" Path="Default/Button_Normal.png" />
              </NodeObjectData>
              <NodeObjectData Name="btn_lvl_2" ActionTag="-429479773" FrameEvent="" Tag="9" ObjectIndex="3" PrePositionEnabled="True" TouchEnable="True" FontSize="72" ButtonText="Level 2" Scale9Width="46" Scale9Height="36" ctype="ButtonObjectData">
                <Position X="540.0000" Y="1535.9999" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <CColor A="255" R="255" G="255" B="255" />
                <Size X="274.0000" Y="95.0000" />
                <PrePosition X="0.5000" Y="0.8000" />
                <PreSize X="0.0000" Y="0.0000" />
                <FontResource Type="Normal" Path="fonts/ALGER.TTF" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Default" Path="Default/Button_Disable.png" />
                <PressedFileData Type="Default" Path="Default/Button_Press.png" />
                <NormalFileData Type="Default" Path="Default/Button_Normal.png" />
              </NodeObjectData>
              <NodeObjectData Name="btn_lvl_3" ActionTag="-1090748223" FrameEvent="" Tag="10" ObjectIndex="4" PrePositionEnabled="True" TouchEnable="True" FontSize="72" ButtonText="Level 3" Scale9Width="46" Scale9Height="36" ctype="ButtonObjectData">
                <Position X="540.0000" Y="1344.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <CColor A="255" R="255" G="255" B="255" />
                <Size X="274.0000" Y="95.0000" />
                <PrePosition X="0.5000" Y="0.7000" />
                <PreSize X="0.0000" Y="0.0000" />
                <FontResource Type="Normal" Path="fonts/ALGER.TTF" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Default" Path="Default/Button_Disable.png" />
                <PressedFileData Type="Default" Path="Default/Button_Press.png" />
                <NormalFileData Type="Default" Path="Default/Button_Normal.png" />
              </NodeObjectData>
            </Children>
            <SingleColor A="255" R="58" G="165" B="255" />
            <FirstColor A="255" R="58" G="165" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
            <InnerNodeSize Width="1080" Height="1920" />
          </NodeObjectData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameProjectFile>