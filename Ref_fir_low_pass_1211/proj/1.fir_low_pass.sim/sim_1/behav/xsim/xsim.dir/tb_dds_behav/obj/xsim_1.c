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
extern void execute_1174(char*, char *);
extern void execute_1175(char*, char *);
extern void execute_1167(char*, char *);
extern void execute_1172(char*, char *);
extern void vlog_simple_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
extern void execute_129(char*, char *);
extern void execute_195(char*, char *);
extern void execute_610(char*, char *);
extern void execute_611(char*, char *);
extern void execute_619(char*, char *);
extern void execute_632(char*, char *);
extern void execute_633(char*, char *);
extern void execute_197(char*, char *);
extern void execute_202(char*, char *);
extern void execute_211(char*, char *);
extern void execute_206(char*, char *);
extern void execute_617(char*, char *);
extern void execute_614(char*, char *);
extern void execute_615(char*, char *);
extern void execute_623(char*, char *);
extern void execute_624(char*, char *);
extern void execute_625(char*, char *);
extern void execute_629(char*, char *);
extern void execute_630(char*, char *);
extern void execute_631(char*, char *);
extern void execute_147(char*, char *);
extern void execute_148(char*, char *);
extern void execute_162(char*, char *);
extern void execute_138(char*, char *);
extern void execute_144(char*, char *);
extern void execute_145(char*, char *);
extern void execute_142(char*, char *);
extern void execute_150(char*, char *);
extern void execute_152(char*, char *);
extern void execute_154(char*, char *);
extern void execute_156(char*, char *);
extern void execute_158(char*, char *);
extern void execute_160(char*, char *);
extern void execute_220(char*, char *);
extern void execute_602(char*, char *);
extern void execute_603(char*, char *);
extern void execute_224(char*, char *);
extern void execute_226(char*, char *);
extern void execute_266(char*, char *);
extern void execute_268(char*, char *);
extern void execute_269(char*, char *);
extern void execute_343(char*, char *);
extern void execute_352(char*, char *);
extern void execute_359(char*, char *);
extern void execute_400(char*, char *);
extern void execute_577(char*, char *);
extern void execute_578(char*, char *);
extern void execute_593(char*, char *);
extern void execute_576(char*, char *);
extern void execute_581(char*, char *);
extern void execute_582(char*, char *);
extern void execute_232(char*, char *);
extern void execute_233(char*, char *);
extern void execute_234(char*, char *);
extern void execute_240(char*, char *);
extern void execute_258(char*, char *);
extern void execute_259(char*, char *);
extern void execute_261(char*, char *);
extern void execute_249(char*, char *);
extern void execute_255(char*, char *);
extern void execute_256(char*, char *);
extern void execute_253(char*, char *);
extern void execute_290(char*, char *);
extern void execute_281(char*, char *);
extern void execute_282(char*, char *);
extern void execute_286(char*, char *);
extern void execute_293(char*, char *);
extern void execute_326(char*, char *);
extern void execute_328(char*, char *);
extern void execute_329(char*, char *);
extern void execute_297(char*, char *);
extern void execute_302(char*, char *);
extern void execute_320(char*, char *);
extern void execute_321(char*, char *);
extern void execute_323(char*, char *);
extern void execute_311(char*, char *);
extern void execute_317(char*, char *);
extern void execute_318(char*, char *);
extern void execute_315(char*, char *);
extern void execute_333(char*, char *);
extern void execute_334(char*, char *);
extern void execute_335(char*, char *);
extern void execute_348(char*, char *);
extern void execute_386(char*, char *);
extern void execute_387(char*, char *);
extern void execute_399(char*, char *);
extern void execute_377(char*, char *);
extern void execute_383(char*, char *);
extern void execute_384(char*, char *);
extern void execute_381(char*, char *);
extern void execute_389(char*, char *);
extern void execute_391(char*, char *);
extern void execute_393(char*, char *);
extern void execute_395(char*, char *);
extern void execute_397(char*, char *);
extern void execute_586(char*, char *);
extern void execute_414(char*, char *);
extern void execute_417(char*, char *);
extern void execute_424(char*, char *);
extern void execute_459(char*, char *);
extern void execute_460(char*, char *);
extern void execute_428(char*, char *);
extern void execute_432(char*, char *);
extern void execute_464(char*, char *);
extern void execute_465(char*, char *);
extern void execute_469(char*, char *);
extern void execute_511(char*, char *);
extern void execute_512(char*, char *);
extern void execute_517(char*, char *);
extern void execute_518(char*, char *);
extern void execute_523(char*, char *);
extern void execute_524(char*, char *);
extern void execute_525(char*, char *);
extern void execute_449(char*, char *);
extern void execute_450(char*, char *);
extern void execute_458(char*, char *);
extern void execute_440(char*, char *);
extern void execute_446(char*, char *);
extern void execute_447(char*, char *);
extern void execute_444(char*, char *);
extern void execute_452(char*, char *);
extern void execute_454(char*, char *);
extern void execute_456(char*, char *);
extern void execute_486(char*, char *);
extern void execute_487(char*, char *);
extern void execute_489(char*, char *);
extern void execute_477(char*, char *);
extern void execute_483(char*, char *);
extern void execute_484(char*, char *);
extern void execute_481(char*, char *);
extern void execute_544(char*, char *);
extern void execute_545(char*, char *);
extern void execute_549(char*, char *);
extern void execute_535(char*, char *);
extern void execute_541(char*, char *);
extern void execute_542(char*, char *);
extern void execute_539(char*, char *);
extern void execute_547(char*, char *);
extern void execute_600(char*, char *);
extern void execute_655(char*, char *);
extern void execute_721(char*, char *);
extern void execute_1129(char*, char *);
extern void execute_1130(char*, char *);
extern void execute_1138(char*, char *);
extern void execute_1151(char*, char *);
extern void execute_1152(char*, char *);
extern void execute_723(char*, char *);
extern void execute_728(char*, char *);
extern void execute_737(char*, char *);
extern void execute_732(char*, char *);
extern void execute_1136(char*, char *);
extern void execute_1133(char*, char *);
extern void execute_1134(char*, char *);
extern void execute_1142(char*, char *);
extern void execute_1143(char*, char *);
extern void execute_1144(char*, char *);
extern void execute_1148(char*, char *);
extern void execute_1149(char*, char *);
extern void execute_1150(char*, char *);
extern void execute_745(char*, char *);
extern void execute_1121(char*, char *);
extern void execute_1122(char*, char *);
extern void execute_749(char*, char *);
extern void execute_751(char*, char *);
extern void execute_791(char*, char *);
extern void execute_793(char*, char *);
extern void execute_794(char*, char *);
extern void execute_868(char*, char *);
extern void execute_877(char*, char *);
extern void execute_884(char*, char *);
extern void execute_925(char*, char *);
extern void execute_1096(char*, char *);
extern void execute_1097(char*, char *);
extern void execute_1112(char*, char *);
extern void execute_1095(char*, char *);
extern void execute_1100(char*, char *);
extern void execute_1101(char*, char *);
extern void execute_815(char*, char *);
extern void execute_806(char*, char *);
extern void execute_807(char*, char *);
extern void execute_811(char*, char *);
extern void execute_818(char*, char *);
extern void execute_851(char*, char *);
extern void execute_853(char*, char *);
extern void execute_854(char*, char *);
extern void execute_1169(char*, char *);
extern void execute_1170(char*, char *);
extern void execute_1171(char*, char *);
extern void execute_1176(char*, char *);
extern void execute_1177(char*, char *);
extern void execute_1178(char*, char *);
extern void execute_1179(char*, char *);
extern void execute_1180(char*, char *);
extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_4(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_6(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_7(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_9(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_10(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_12(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_13(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_14(char*, char*, unsigned, unsigned, unsigned);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_60(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_61(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_67(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_68(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_71(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_72(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_73(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_94(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_98(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_105(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_114(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_228(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_245(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_246(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_371(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_417(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_418(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_424(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_425(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_428(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_429(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_430(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_451(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_455(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_462(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_471(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_557(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_574(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_575(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[239] = {(funcp)execute_2, (funcp)execute_3, (funcp)execute_1174, (funcp)execute_1175, (funcp)execute_1167, (funcp)execute_1172, (funcp)vlog_simple_process_execute_0_fast_no_reg_no_agg, (funcp)execute_129, (funcp)execute_195, (funcp)execute_610, (funcp)execute_611, (funcp)execute_619, (funcp)execute_632, (funcp)execute_633, (funcp)execute_197, (funcp)execute_202, (funcp)execute_211, (funcp)execute_206, (funcp)execute_617, (funcp)execute_614, (funcp)execute_615, (funcp)execute_623, (funcp)execute_624, (funcp)execute_625, (funcp)execute_629, (funcp)execute_630, (funcp)execute_631, (funcp)execute_147, (funcp)execute_148, (funcp)execute_162, (funcp)execute_138, (funcp)execute_144, (funcp)execute_145, (funcp)execute_142, (funcp)execute_150, (funcp)execute_152, (funcp)execute_154, (funcp)execute_156, (funcp)execute_158, (funcp)execute_160, (funcp)execute_220, (funcp)execute_602, (funcp)execute_603, (funcp)execute_224, (funcp)execute_226, (funcp)execute_266, (funcp)execute_268, (funcp)execute_269, (funcp)execute_343, (funcp)execute_352, (funcp)execute_359, (funcp)execute_400, (funcp)execute_577, (funcp)execute_578, (funcp)execute_593, (funcp)execute_576, (funcp)execute_581, (funcp)execute_582, (funcp)execute_232, (funcp)execute_233, (funcp)execute_234, (funcp)execute_240, (funcp)execute_258, (funcp)execute_259, (funcp)execute_261, (funcp)execute_249, (funcp)execute_255, (funcp)execute_256, (funcp)execute_253, (funcp)execute_290, (funcp)execute_281, (funcp)execute_282, (funcp)execute_286, (funcp)execute_293, (funcp)execute_326, (funcp)execute_328, (funcp)execute_329, (funcp)execute_297, (funcp)execute_302, (funcp)execute_320, (funcp)execute_321, (funcp)execute_323, (funcp)execute_311, (funcp)execute_317, (funcp)execute_318, (funcp)execute_315, (funcp)execute_333, (funcp)execute_334, (funcp)execute_335, (funcp)execute_348, (funcp)execute_386, (funcp)execute_387, (funcp)execute_399, (funcp)execute_377, (funcp)execute_383, (funcp)execute_384, (funcp)execute_381, (funcp)execute_389, (funcp)execute_391, (funcp)execute_393, (funcp)execute_395, (funcp)execute_397, (funcp)execute_586, (funcp)execute_414, (funcp)execute_417, (funcp)execute_424, (funcp)execute_459, (funcp)execute_460, (funcp)execute_428, (funcp)execute_432, (funcp)execute_464, (funcp)execute_465, (funcp)execute_469, (funcp)execute_511, (funcp)execute_512, (funcp)execute_517, (funcp)execute_518, (funcp)execute_523, (funcp)execute_524, (funcp)execute_525, (funcp)execute_449, (funcp)execute_450, (funcp)execute_458, (funcp)execute_440, (funcp)execute_446, (funcp)execute_447, (funcp)execute_444, (funcp)execute_452, (funcp)execute_454, (funcp)execute_456, (funcp)execute_486, (funcp)execute_487, (funcp)execute_489, (funcp)execute_477, (funcp)execute_483, (funcp)execute_484, (funcp)execute_481, (funcp)execute_544, (funcp)execute_545, (funcp)execute_549, (funcp)execute_535, (funcp)execute_541, (funcp)execute_542, (funcp)execute_539, (funcp)execute_547, (funcp)execute_600, (funcp)execute_655, (funcp)execute_721, (funcp)execute_1129, (funcp)execute_1130, (funcp)execute_1138, (funcp)execute_1151, (funcp)execute_1152, (funcp)execute_723, (funcp)execute_728, (funcp)execute_737, (funcp)execute_732, (funcp)execute_1136, (funcp)execute_1133, (funcp)execute_1134, (funcp)execute_1142, (funcp)execute_1143, (funcp)execute_1144, (funcp)execute_1148, (funcp)execute_1149, (funcp)execute_1150, (funcp)execute_745, (funcp)execute_1121, (funcp)execute_1122, (funcp)execute_749, (funcp)execute_751, (funcp)execute_791, (funcp)execute_793, (funcp)execute_794, (funcp)execute_868, (funcp)execute_877, (funcp)execute_884, (funcp)execute_925, (funcp)execute_1096, (funcp)execute_1097, (funcp)execute_1112, (funcp)execute_1095, (funcp)execute_1100, (funcp)execute_1101, (funcp)execute_815, (funcp)execute_806, (funcp)execute_807, (funcp)execute_811, (funcp)execute_818, (funcp)execute_851, (funcp)execute_853, (funcp)execute_854, (funcp)execute_1169, (funcp)execute_1170, (funcp)execute_1171, (funcp)execute_1176, (funcp)execute_1177, (funcp)execute_1178, (funcp)execute_1179, (funcp)execute_1180, (funcp)vlog_transfunc_eventcallback, (funcp)transaction_4, (funcp)transaction_6, (funcp)transaction_7, (funcp)transaction_9, (funcp)transaction_10, (funcp)transaction_12, (funcp)transaction_13, (funcp)transaction_14, (funcp)vhdl_transfunc_eventcallback, (funcp)transaction_60, (funcp)transaction_61, (funcp)transaction_67, (funcp)transaction_68, (funcp)transaction_71, (funcp)transaction_72, (funcp)transaction_73, (funcp)transaction_94, (funcp)transaction_98, (funcp)transaction_105, (funcp)transaction_114, (funcp)transaction_228, (funcp)transaction_245, (funcp)transaction_246, (funcp)transaction_371, (funcp)transaction_417, (funcp)transaction_418, (funcp)transaction_424, (funcp)transaction_425, (funcp)transaction_428, (funcp)transaction_429, (funcp)transaction_430, (funcp)transaction_451, (funcp)transaction_455, (funcp)transaction_462, (funcp)transaction_471, (funcp)transaction_557, (funcp)transaction_574, (funcp)transaction_575};
const int NumRelocateId= 239;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/tb_dds_behav/xsim.reloc",  (void **)funcTab, 239);
	iki_vhdl_file_variable_register(dp + 203960);
	iki_vhdl_file_variable_register(dp + 204016);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/tb_dds_behav/xsim.reloc");
}

	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net

void wrapper_func_0(char *dp)

{

	iki_vlog_schedule_transaction_signal_fast_vhdl_value_time_0(dp + 474688, dp + 473520, 0, 11, 4, 15, 12, 1);

	iki_vlog_schedule_transaction_signal_fast_vhdl_value_time_0(dp + 594584, dp + 473576, 0, 11, 4, 15, 12, 1);

	iki_vlog_schedule_transaction_signal_fast_vhdl_value_time_0(dp + 474632, dp + 473688, 0, 0, 0, 0, 1, 1);

	iki_vlog_schedule_transaction_signal_fast_vhdl_value_time_0(dp + 594528, dp + 473744, 0, 0, 0, 0, 1, 1);

	iki_vlog_schedule_transaction_signal_fast_vhdl_value_time_0(dp + 594584, dp + 473856, 0, 3, 0, 3, 4, 1);

	iki_vlog_schedule_transaction_signal_fast_vhdl_value_time_0(dp + 474688, dp + 473912, 0, 3, 0, 3, 4, 1);

}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/tb_dds_behav/xsim.reloc");
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
    iki_set_sv_type_file_path_name("xsim.dir/tb_dds_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/tb_dds_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/tb_dds_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
