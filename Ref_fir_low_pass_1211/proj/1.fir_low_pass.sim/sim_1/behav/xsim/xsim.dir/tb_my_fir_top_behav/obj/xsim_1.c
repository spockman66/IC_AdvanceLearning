/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_2(char*, char *);
extern void execute_3(char*, char *);
extern void execute_1184(char*, char *);
extern void execute_1185(char*, char *);
extern void execute_1168(char*, char *);
extern void execute_1180(char*, char *);
extern void vlog_simple_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
extern void execute_130(char*, char *);
extern void execute_196(char*, char *);
extern void execute_611(char*, char *);
extern void execute_612(char*, char *);
extern void execute_620(char*, char *);
extern void execute_633(char*, char *);
extern void execute_634(char*, char *);
extern void execute_198(char*, char *);
extern void execute_203(char*, char *);
extern void execute_212(char*, char *);
extern void execute_207(char*, char *);
extern void execute_618(char*, char *);
extern void execute_615(char*, char *);
extern void execute_616(char*, char *);
extern void execute_624(char*, char *);
extern void execute_625(char*, char *);
extern void execute_626(char*, char *);
extern void execute_630(char*, char *);
extern void execute_631(char*, char *);
extern void execute_632(char*, char *);
extern void execute_148(char*, char *);
extern void execute_149(char*, char *);
extern void execute_163(char*, char *);
extern void execute_139(char*, char *);
extern void execute_145(char*, char *);
extern void execute_146(char*, char *);
extern void execute_143(char*, char *);
extern void execute_151(char*, char *);
extern void execute_153(char*, char *);
extern void execute_155(char*, char *);
extern void execute_157(char*, char *);
extern void execute_159(char*, char *);
extern void execute_161(char*, char *);
extern void execute_221(char*, char *);
extern void execute_603(char*, char *);
extern void execute_604(char*, char *);
extern void execute_225(char*, char *);
extern void execute_227(char*, char *);
extern void execute_267(char*, char *);
extern void execute_269(char*, char *);
extern void execute_270(char*, char *);
extern void execute_344(char*, char *);
extern void execute_353(char*, char *);
extern void execute_360(char*, char *);
extern void execute_401(char*, char *);
extern void execute_578(char*, char *);
extern void execute_579(char*, char *);
extern void execute_594(char*, char *);
extern void execute_577(char*, char *);
extern void execute_582(char*, char *);
extern void execute_583(char*, char *);
extern void execute_233(char*, char *);
extern void execute_234(char*, char *);
extern void execute_235(char*, char *);
extern void execute_241(char*, char *);
extern void execute_259(char*, char *);
extern void execute_260(char*, char *);
extern void execute_262(char*, char *);
extern void execute_250(char*, char *);
extern void execute_256(char*, char *);
extern void execute_257(char*, char *);
extern void execute_254(char*, char *);
extern void execute_291(char*, char *);
extern void execute_282(char*, char *);
extern void execute_283(char*, char *);
extern void execute_287(char*, char *);
extern void execute_294(char*, char *);
extern void execute_327(char*, char *);
extern void execute_329(char*, char *);
extern void execute_330(char*, char *);
extern void execute_298(char*, char *);
extern void execute_303(char*, char *);
extern void execute_321(char*, char *);
extern void execute_322(char*, char *);
extern void execute_324(char*, char *);
extern void execute_312(char*, char *);
extern void execute_318(char*, char *);
extern void execute_319(char*, char *);
extern void execute_316(char*, char *);
extern void execute_334(char*, char *);
extern void execute_335(char*, char *);
extern void execute_336(char*, char *);
extern void execute_349(char*, char *);
extern void execute_387(char*, char *);
extern void execute_388(char*, char *);
extern void execute_400(char*, char *);
extern void execute_378(char*, char *);
extern void execute_384(char*, char *);
extern void execute_385(char*, char *);
extern void execute_382(char*, char *);
extern void execute_390(char*, char *);
extern void execute_392(char*, char *);
extern void execute_394(char*, char *);
extern void execute_396(char*, char *);
extern void execute_398(char*, char *);
extern void execute_587(char*, char *);
extern void execute_415(char*, char *);
extern void execute_418(char*, char *);
extern void execute_425(char*, char *);
extern void execute_460(char*, char *);
extern void execute_461(char*, char *);
extern void execute_429(char*, char *);
extern void execute_433(char*, char *);
extern void execute_465(char*, char *);
extern void execute_466(char*, char *);
extern void execute_470(char*, char *);
extern void execute_512(char*, char *);
extern void execute_513(char*, char *);
extern void execute_518(char*, char *);
extern void execute_519(char*, char *);
extern void execute_524(char*, char *);
extern void execute_525(char*, char *);
extern void execute_526(char*, char *);
extern void execute_450(char*, char *);
extern void execute_451(char*, char *);
extern void execute_459(char*, char *);
extern void execute_441(char*, char *);
extern void execute_447(char*, char *);
extern void execute_448(char*, char *);
extern void execute_445(char*, char *);
extern void execute_453(char*, char *);
extern void execute_455(char*, char *);
extern void execute_457(char*, char *);
extern void execute_487(char*, char *);
extern void execute_488(char*, char *);
extern void execute_490(char*, char *);
extern void execute_478(char*, char *);
extern void execute_484(char*, char *);
extern void execute_485(char*, char *);
extern void execute_482(char*, char *);
extern void execute_545(char*, char *);
extern void execute_546(char*, char *);
extern void execute_550(char*, char *);
extern void execute_536(char*, char *);
extern void execute_542(char*, char *);
extern void execute_543(char*, char *);
extern void execute_540(char*, char *);
extern void execute_548(char*, char *);
extern void execute_601(char*, char *);
extern void execute_656(char*, char *);
extern void execute_722(char*, char *);
extern void execute_1130(char*, char *);
extern void execute_1131(char*, char *);
extern void execute_1139(char*, char *);
extern void execute_1152(char*, char *);
extern void execute_1153(char*, char *);
extern void execute_724(char*, char *);
extern void execute_729(char*, char *);
extern void execute_738(char*, char *);
extern void execute_733(char*, char *);
extern void execute_1137(char*, char *);
extern void execute_1134(char*, char *);
extern void execute_1135(char*, char *);
extern void execute_1143(char*, char *);
extern void execute_1144(char*, char *);
extern void execute_1145(char*, char *);
extern void execute_1149(char*, char *);
extern void execute_1150(char*, char *);
extern void execute_1151(char*, char *);
extern void execute_746(char*, char *);
extern void execute_1122(char*, char *);
extern void execute_1123(char*, char *);
extern void execute_750(char*, char *);
extern void execute_752(char*, char *);
extern void execute_792(char*, char *);
extern void execute_794(char*, char *);
extern void execute_795(char*, char *);
extern void execute_869(char*, char *);
extern void execute_878(char*, char *);
extern void execute_885(char*, char *);
extern void execute_926(char*, char *);
extern void execute_1097(char*, char *);
extern void execute_1098(char*, char *);
extern void execute_1113(char*, char *);
extern void execute_1096(char*, char *);
extern void execute_1101(char*, char *);
extern void execute_1102(char*, char *);
extern void execute_816(char*, char *);
extern void execute_807(char*, char *);
extern void execute_808(char*, char *);
extern void execute_812(char*, char *);
extern void execute_819(char*, char *);
extern void execute_852(char*, char *);
extern void execute_854(char*, char *);
extern void execute_855(char*, char *);
extern void execute_1170(char*, char *);
extern void execute_1171(char*, char *);
extern void execute_1172(char*, char *);
extern void execute_1173(char*, char *);
extern void execute_1174(char*, char *);
extern void execute_1175(char*, char *);
extern void execute_1182(char*, char *);
extern void execute_1177(char*, char *);
extern void execute_1178(char*, char *);
extern void execute_1179(char*, char *);
extern void execute_1186(char*, char *);
extern void execute_1187(char*, char *);
extern void execute_1188(char*, char *);
extern void execute_1189(char*, char *);
extern void execute_1190(char*, char *);
extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_4(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_8(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_9(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_11(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_12(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_13(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_14(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_15(char*, char*, unsigned, unsigned, unsigned);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_61(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_62(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_68(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_69(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_72(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_73(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_74(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_95(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_99(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_106(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_115(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_229(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_246(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_247(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_372(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_418(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_419(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_425(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_426(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_429(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_430(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_431(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_452(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_456(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_463(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_472(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_558(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_575(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_576(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[246] = {(funcp)execute_2, (funcp)execute_3, (funcp)execute_1184, (funcp)execute_1185, (funcp)execute_1168, (funcp)execute_1180, (funcp)vlog_simple_process_execute_0_fast_no_reg_no_agg, (funcp)execute_130, (funcp)execute_196, (funcp)execute_611, (funcp)execute_612, (funcp)execute_620, (funcp)execute_633, (funcp)execute_634, (funcp)execute_198, (funcp)execute_203, (funcp)execute_212, (funcp)execute_207, (funcp)execute_618, (funcp)execute_615, (funcp)execute_616, (funcp)execute_624, (funcp)execute_625, (funcp)execute_626, (funcp)execute_630, (funcp)execute_631, (funcp)execute_632, (funcp)execute_148, (funcp)execute_149, (funcp)execute_163, (funcp)execute_139, (funcp)execute_145, (funcp)execute_146, (funcp)execute_143, (funcp)execute_151, (funcp)execute_153, (funcp)execute_155, (funcp)execute_157, (funcp)execute_159, (funcp)execute_161, (funcp)execute_221, (funcp)execute_603, (funcp)execute_604, (funcp)execute_225, (funcp)execute_227, (funcp)execute_267, (funcp)execute_269, (funcp)execute_270, (funcp)execute_344, (funcp)execute_353, (funcp)execute_360, (funcp)execute_401, (funcp)execute_578, (funcp)execute_579, (funcp)execute_594, (funcp)execute_577, (funcp)execute_582, (funcp)execute_583, (funcp)execute_233, (funcp)execute_234, (funcp)execute_235, (funcp)execute_241, (funcp)execute_259, (funcp)execute_260, (funcp)execute_262, (funcp)execute_250, (funcp)execute_256, (funcp)execute_257, (funcp)execute_254, (funcp)execute_291, (funcp)execute_282, (funcp)execute_283, (funcp)execute_287, (funcp)execute_294, (funcp)execute_327, (funcp)execute_329, (funcp)execute_330, (funcp)execute_298, (funcp)execute_303, (funcp)execute_321, (funcp)execute_322, (funcp)execute_324, (funcp)execute_312, (funcp)execute_318, (funcp)execute_319, (funcp)execute_316, (funcp)execute_334, (funcp)execute_335, (funcp)execute_336, (funcp)execute_349, (funcp)execute_387, (funcp)execute_388, (funcp)execute_400, (funcp)execute_378, (funcp)execute_384, (funcp)execute_385, (funcp)execute_382, (funcp)execute_390, (funcp)execute_392, (funcp)execute_394, (funcp)execute_396, (funcp)execute_398, (funcp)execute_587, (funcp)execute_415, (funcp)execute_418, (funcp)execute_425, (funcp)execute_460, (funcp)execute_461, (funcp)execute_429, (funcp)execute_433, (funcp)execute_465, (funcp)execute_466, (funcp)execute_470, (funcp)execute_512, (funcp)execute_513, (funcp)execute_518, (funcp)execute_519, (funcp)execute_524, (funcp)execute_525, (funcp)execute_526, (funcp)execute_450, (funcp)execute_451, (funcp)execute_459, (funcp)execute_441, (funcp)execute_447, (funcp)execute_448, (funcp)execute_445, (funcp)execute_453, (funcp)execute_455, (funcp)execute_457, (funcp)execute_487, (funcp)execute_488, (funcp)execute_490, (funcp)execute_478, (funcp)execute_484, (funcp)execute_485, (funcp)execute_482, (funcp)execute_545, (funcp)execute_546, (funcp)execute_550, (funcp)execute_536, (funcp)execute_542, (funcp)execute_543, (funcp)execute_540, (funcp)execute_548, (funcp)execute_601, (funcp)execute_656, (funcp)execute_722, (funcp)execute_1130, (funcp)execute_1131, (funcp)execute_1139, (funcp)execute_1152, (funcp)execute_1153, (funcp)execute_724, (funcp)execute_729, (funcp)execute_738, (funcp)execute_733, (funcp)execute_1137, (funcp)execute_1134, (funcp)execute_1135, (funcp)execute_1143, (funcp)execute_1144, (funcp)execute_1145, (funcp)execute_1149, (funcp)execute_1150, (funcp)execute_1151, (funcp)execute_746, (funcp)execute_1122, (funcp)execute_1123, (funcp)execute_750, (funcp)execute_752, (funcp)execute_792, (funcp)execute_794, (funcp)execute_795, (funcp)execute_869, (funcp)execute_878, (funcp)execute_885, (funcp)execute_926, (funcp)execute_1097, (funcp)execute_1098, (funcp)execute_1113, (funcp)execute_1096, (funcp)execute_1101, (funcp)execute_1102, (funcp)execute_816, (funcp)execute_807, (funcp)execute_808, (funcp)execute_812, (funcp)execute_819, (funcp)execute_852, (funcp)execute_854, (funcp)execute_855, (funcp)execute_1170, (funcp)execute_1171, (funcp)execute_1172, (funcp)execute_1173, (funcp)execute_1174, (funcp)execute_1175, (funcp)execute_1182, (funcp)execute_1177, (funcp)execute_1178, (funcp)execute_1179, (funcp)execute_1186, (funcp)execute_1187, (funcp)execute_1188, (funcp)execute_1189, (funcp)execute_1190, (funcp)vlog_transfunc_eventcallback, (funcp)transaction_4, (funcp)transaction_8, (funcp)transaction_9, (funcp)transaction_11, (funcp)transaction_12, (funcp)transaction_13, (funcp)transaction_14, (funcp)transaction_15, (funcp)vhdl_transfunc_eventcallback, (funcp)transaction_61, (funcp)transaction_62, (funcp)transaction_68, (funcp)transaction_69, (funcp)transaction_72, (funcp)transaction_73, (funcp)transaction_74, (funcp)transaction_95, (funcp)transaction_99, (funcp)transaction_106, (funcp)transaction_115, (funcp)transaction_229, (funcp)transaction_246, (funcp)transaction_247, (funcp)transaction_372, (funcp)transaction_418, (funcp)transaction_419, (funcp)transaction_425, (funcp)transaction_426, (funcp)transaction_429, (funcp)transaction_430, (funcp)transaction_431, (funcp)transaction_452, (funcp)transaction_456, (funcp)transaction_463, (funcp)transaction_472, (funcp)transaction_558, (funcp)transaction_575, (funcp)transaction_576};
const int NumRelocateId= 246;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/tb_my_fir_top_behav/xsim.reloc",  (void **)funcTab, 246);
	iki_vhdl_file_variable_register(dp + 220928);
	iki_vhdl_file_variable_register(dp + 220984);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/tb_my_fir_top_behav/xsim.reloc");
}

	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net

void wrapper_func_0(char *dp)

{

	iki_vlog_schedule_transaction_signal_fast_vhdl_value_time_0(dp + 491984, dp + 490872, 0, 11, 4, 15, 12, 1);

	iki_vlog_schedule_transaction_signal_fast_vhdl_value_time_0(dp + 611864, dp + 490928, 0, 11, 4, 15, 12, 1);

	iki_vlog_schedule_transaction_signal_fast_vhdl_value_time_0(dp + 491928, dp + 491040, 0, 0, 0, 0, 1, 1);

	iki_vlog_schedule_transaction_signal_fast_vhdl_value_time_0(dp + 611808, dp + 491096, 0, 0, 0, 0, 1, 1);

	iki_vlog_schedule_transaction_signal_fast_vhdl_value_time_0(dp + 611864, dp + 491152, 0, 3, 0, 3, 4, 1);

	iki_vlog_schedule_transaction_signal_fast_vhdl_value_time_0(dp + 491984, dp + 491208, 0, 3, 0, 3, 4, 1);

}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/tb_my_fir_top_behav/xsim.reloc");
	wrapper_func_0(dp);

	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstatiate();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/tb_my_fir_top_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/tb_my_fir_top_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/tb_my_fir_top_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
