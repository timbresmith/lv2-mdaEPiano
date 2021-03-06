#ifndef MDA_EPIANO_H
#define MDA_EPIANO_H
//See associated .cpp file for copyright and other info

#include <lv2synth.hpp>
#include "mdaEPianoVoice.h"
#include "mdaEPiano.peg"

class mdaEPianoProgram
{
	friend class mdaEPiano;
	private:
	float param[NPARAMS];
	char  name[24];
};

class mdaEPiano : public LV2::Synth<mdaEPianoVoice, mdaEPiano> {
	private:
		unsigned char controllers[NPARAMS]; //controller mapping
	public:
		uint32_t curProgram;
		bool sustain;
		float modwhl;

		mdaEPianoVoice *voices[NVOICES]; //container for all voices
		mdaEPianoProgram programs[NPROGS];

		mdaEPiano(double rate);
		signed char get_param_id_from_controller(unsigned char cc);
		unsigned find_free_voice(unsigned char key, unsigned char velocity);
		void handle_midi(uint32_t size, unsigned char* data);
		void setVolume(float value);
		void setParameter(unsigned char id, float value);
		void setProgram(uint32_t program);

		//parameter change
		void update(void);
		void fillpatch(uint32_t p, const char *name, float p0, float p1,
				float p2, float p3,
				float p4, float p5,
				float p6, float p7,
				float p8, float p9,
				float p10, float p11);
};
#endif
