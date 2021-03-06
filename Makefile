BUNDLE = lv2-mdaEPiano.lv2
INSTALL_DIR = /usr/local/lib/lv2


$(BUNDLE): manifest.ttl mdaEPiano.ttl mdaEPiano.so mdaEPianoGUI.so
		rm -rf $(BUNDLE)
			mkdir $(BUNDLE)
				cp $^ $(BUNDLE)

mdaEPiano.so: mdaEPiano.cpp mdaEPianoVoice.cpp mdaEPianoData.cpp mdaEPiano.peg
		g++ -shared -fPIC -DPIC mdaEPiano.cpp mdaEPianoVoice.cpp mdaEPianoData.cpp `pkg-config --cflags --libs lv2-plugin` -o mdaEPiano.so

mdaEPianoGUI.so: mdaEPianoGUI.cpp mdaEPiano.peg
	g++ -shared -fPIC -DPIC mdaEPianoGUI.cpp `pkg-config --cflags --libs lv2-gui` -o mdaEPianoGUI.so

mdaEPiano.peg: mdaEPiano.ttl
		lv2peg mdaEPiano.ttl mdaEPiano.peg

install: $(BUNDLE)
		mkdir -p $(INSTALL_DIR)
			rm -rf $(INSTALL_DIR)/$(BUNDLE)
				cp -R $(BUNDLE) $(INSTALL_DIR)

clean:
		rm -rf $(BUNDLE) mdaEPiano.so mdaEPiano.peg mdaEPianoGUI.so
