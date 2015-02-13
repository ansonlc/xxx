# xxx
Magic Puzzle

文件夹说明：
XXXArtDesign --- Cocos Studio工程文件夹
XXXCocosLuaGame --- 游戏源代码文件夹
XXXResources --- 游戏素材PSD工程文件夹

素材导入流程：

1. 将XXXResources中的PSD分割导出到XXXResources下另存为png文件夹
2. 打开XXXArtDesign中的Cocos Studio工程，使用Import将上一步的png导入到工程中
3. 编辑完Cocos Studio工程后，点击发布，使用了的素材会自动导入到XXXCocosLuaGame\res中
4. 清理（删除）XXXResources文件夹下的png文件
