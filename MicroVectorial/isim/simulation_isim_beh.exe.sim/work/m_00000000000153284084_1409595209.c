/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/Daniel/Desktop/TEC/TEC XIII Semestre/Arqui II/MicroprocesadorVectorial/Pipeline_Source/rom32.v";
static unsigned int ng1[] = {0U, 0U};
static int ng2[] = {4, 0};
static int ng3[] = {0, 0};
static const char *ng4 = "";
static const char *ng5 = " rom32 error: unaligned address %d";
static int ng6[] = {1, 0};
static unsigned int ng7[] = {402784261U, 0U};
static unsigned int ng8[] = {1U, 0U};
static unsigned int ng9[] = {2U, 0U};
static unsigned int ng10[] = {3U, 0U};
static unsigned int ng11[] = {402915338U, 0U};
static unsigned int ng12[] = {4U, 0U};
static unsigned int ng13[] = {5U, 0U};
static unsigned int ng14[] = {6U, 0U};
static unsigned int ng15[] = {7U, 0U};
static unsigned int ng16[] = {679616512U, 0U};
static unsigned int ng17[] = {4294967295U, 4294967295U};
static const char *ng18 = " reading data: rom32[%h] => %h";



static void Cont_17_0(char *t0)
{
    char t3[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    unsigned int t17;
    unsigned int t18;
    char *t19;
    unsigned int t20;
    unsigned int t21;
    char *t22;
    unsigned int t23;
    unsigned int t24;
    char *t25;

LAB0:    t1 = (t0 + 2824U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(17, ng0);
    t2 = (t0 + 1184U);
    t4 = *((char **)t2);
    memset(t3, 0, 8);
    t2 = (t3 + 4);
    t5 = (t4 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (t6 >> 2);
    *((unsigned int *)t3) = t7;
    t8 = *((unsigned int *)t5);
    t9 = (t8 >> 2);
    *((unsigned int *)t2) = t9;
    t10 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t10 & 63U);
    t11 = *((unsigned int *)t2);
    *((unsigned int *)t2) = (t11 & 63U);
    t12 = (t0 + 3752);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memset(t16, 0, 8);
    t17 = 63U;
    t18 = t17;
    t19 = (t3 + 4);
    t20 = *((unsigned int *)t3);
    t17 = (t17 & t20);
    t21 = *((unsigned int *)t19);
    t18 = (t18 & t21);
    t22 = (t16 + 4);
    t23 = *((unsigned int *)t16);
    *((unsigned int *)t16) = (t23 | t17);
    t24 = *((unsigned int *)t22);
    *((unsigned int *)t22) = (t24 | t18);
    xsi_driver_vfirst_trans(t12, 0, 5);
    t25 = (t0 + 3640);
    *((int *)t25) = 1;

LAB1:    return;
}

static void Cont_19_1(char *t0)
{
    char t3[8];
    char t13[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    char *t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    unsigned int t37;
    unsigned int t38;
    char *t39;
    unsigned int t40;
    unsigned int t41;
    char *t42;

LAB0:    t1 = (t0 + 3072U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(19, ng0);
    t2 = (t0 + 1184U);
    t4 = *((char **)t2);
    memset(t3, 0, 8);
    t2 = (t3 + 4);
    t5 = (t4 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (t6 >> 8);
    *((unsigned int *)t3) = t7;
    t8 = *((unsigned int *)t5);
    t9 = (t8 >> 8);
    *((unsigned int *)t2) = t9;
    t10 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t10 & 16777215U);
    t11 = *((unsigned int *)t2);
    *((unsigned int *)t2) = (t11 & 16777215U);
    t12 = ((char*)((ng1)));
    memset(t13, 0, 8);
    t14 = (t3 + 4);
    t15 = (t12 + 4);
    t16 = *((unsigned int *)t3);
    t17 = *((unsigned int *)t12);
    t18 = (t16 ^ t17);
    t19 = *((unsigned int *)t14);
    t20 = *((unsigned int *)t15);
    t21 = (t19 ^ t20);
    t22 = (t18 | t21);
    t23 = *((unsigned int *)t14);
    t24 = *((unsigned int *)t15);
    t25 = (t23 | t24);
    t26 = (~(t25));
    t27 = (t22 & t26);
    if (t27 != 0)
        goto LAB7;

LAB4:    if (t25 != 0)
        goto LAB6;

LAB5:    *((unsigned int *)t13) = 1;

LAB7:    t29 = (t0 + 3816);
    t30 = (t29 + 56U);
    t31 = *((char **)t30);
    t32 = (t31 + 56U);
    t33 = *((char **)t32);
    memset(t33, 0, 8);
    t34 = 1U;
    t35 = t34;
    t36 = (t13 + 4);
    t37 = *((unsigned int *)t13);
    t34 = (t34 & t37);
    t38 = *((unsigned int *)t36);
    t35 = (t35 & t38);
    t39 = (t33 + 4);
    t40 = *((unsigned int *)t33);
    *((unsigned int *)t33) = (t40 | t34);
    t41 = *((unsigned int *)t39);
    *((unsigned int *)t39) = (t41 | t35);
    xsi_driver_vfirst_trans(t29, 0, 0);
    t42 = (t0 + 3656);
    *((int *)t42) = 1;

LAB1:    return;
LAB6:    t28 = (t13 + 4);
    *((unsigned int *)t13) = 1;
    *((unsigned int *)t28) = 1;
    goto LAB7;

}

static void Always_21_2(char *t0)
{
    char t6[8];
    char t8[8];
    char t30[16];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t7;
    char *t9;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    char *t23;
    char *t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    char *t31;
    char *t32;
    char *t33;
    int t34;

LAB0:    t1 = (t0 + 3320U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(21, ng0);
    t2 = (t0 + 3672);
    *((int *)t2) = 1;
    t3 = (t0 + 3352);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(23, ng0);

LAB5:    xsi_set_current_line(24, ng0);
    t4 = (t0 + 1184U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t6, 0, 8);
    xsi_vlog_unsigned_mod(t6, 32, t5, 32, t4, 32);
    t7 = ((char*)((ng3)));
    memset(t8, 0, 8);
    t9 = (t6 + 4);
    t10 = (t7 + 4);
    t11 = *((unsigned int *)t6);
    t12 = *((unsigned int *)t7);
    t13 = (t11 ^ t12);
    t14 = *((unsigned int *)t9);
    t15 = *((unsigned int *)t10);
    t16 = (t14 ^ t15);
    t17 = (t13 | t16);
    t18 = *((unsigned int *)t9);
    t19 = *((unsigned int *)t10);
    t20 = (t18 | t19);
    t21 = (~(t20));
    t22 = (t17 & t21);
    if (t22 != 0)
        goto LAB7;

LAB6:    if (t20 != 0)
        goto LAB8;

LAB9:    t24 = (t8 + 4);
    t25 = *((unsigned int *)t24);
    t26 = (~(t25));
    t27 = *((unsigned int *)t8);
    t28 = (t27 & t26);
    t29 = (t28 != 0);
    if (t29 > 0)
        goto LAB10;

LAB11:
LAB12:    xsi_set_current_line(25, ng0);
    t2 = (t0 + 1504U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng6)));
    memset(t6, 0, 8);
    t4 = (t3 + 4);
    t5 = (t2 + 4);
    t11 = *((unsigned int *)t3);
    t12 = *((unsigned int *)t2);
    t13 = (t11 ^ t12);
    t14 = *((unsigned int *)t4);
    t15 = *((unsigned int *)t5);
    t16 = (t14 ^ t15);
    t17 = (t13 | t16);
    t18 = *((unsigned int *)t4);
    t19 = *((unsigned int *)t5);
    t20 = (t18 | t19);
    t21 = (~(t20));
    t22 = (t17 & t21);
    if (t22 != 0)
        goto LAB16;

LAB13:    if (t20 != 0)
        goto LAB15;

LAB14:    *((unsigned int *)t6) = 1;

LAB16:    t9 = (t6 + 4);
    t25 = *((unsigned int *)t9);
    t26 = (~(t25));
    t27 = *((unsigned int *)t6);
    t28 = (t27 & t26);
    t29 = (t28 != 0);
    if (t29 > 0)
        goto LAB17;

LAB18:
LAB19:    goto LAB2;

LAB7:    *((unsigned int *)t8) = 1;
    goto LAB9;

LAB8:    t23 = (t8 + 4);
    *((unsigned int *)t8) = 1;
    *((unsigned int *)t23) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(24, ng0);
    t31 = xsi_vlog_time(t30, 1000.0000000000000, 1000.0000000000000);
    xsi_vlogfile_write(0, 0, 0, ng4, 2, t0, (char)118, t30, 64);
    t32 = (t0 + 1184U);
    t33 = *((char **)t32);
    xsi_vlogfile_write(1, 0, 0, ng5, 2, t0, (char)118, t33, 32);
    goto LAB12;

LAB15:    t7 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t7) = 1;
    goto LAB16;

LAB17:    xsi_set_current_line(26, ng0);

LAB20:    xsi_set_current_line(27, ng0);
    t10 = (t0 + 1344U);
    t23 = *((char **)t10);

LAB21:    t10 = ((char*)((ng1)));
    t34 = xsi_vlog_unsigned_case_compare(t23, 6, t10, 6);
    if (t34 == 1)
        goto LAB22;

LAB23:    t2 = ((char*)((ng8)));
    t34 = xsi_vlog_unsigned_case_compare(t23, 6, t2, 6);
    if (t34 == 1)
        goto LAB24;

LAB25:    t2 = ((char*)((ng9)));
    t34 = xsi_vlog_unsigned_case_compare(t23, 6, t2, 6);
    if (t34 == 1)
        goto LAB26;

LAB27:    t2 = ((char*)((ng10)));
    t34 = xsi_vlog_unsigned_case_compare(t23, 6, t2, 6);
    if (t34 == 1)
        goto LAB28;

LAB29:    t2 = ((char*)((ng12)));
    t34 = xsi_vlog_unsigned_case_compare(t23, 6, t2, 6);
    if (t34 == 1)
        goto LAB30;

LAB31:    t2 = ((char*)((ng13)));
    t34 = xsi_vlog_unsigned_case_compare(t23, 6, t2, 6);
    if (t34 == 1)
        goto LAB32;

LAB33:    t2 = ((char*)((ng14)));
    t34 = xsi_vlog_unsigned_case_compare(t23, 6, t2, 6);
    if (t34 == 1)
        goto LAB34;

LAB35:    t2 = ((char*)((ng15)));
    t34 = xsi_vlog_unsigned_case_compare(t23, 6, t2, 6);
    if (t34 == 1)
        goto LAB36;

LAB37:
LAB39:
LAB38:    xsi_set_current_line(75, ng0);
    t2 = ((char*)((ng17)));
    t3 = (t0 + 1904);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB40:    xsi_set_current_line(78, ng0);
    t2 = xsi_vlog_time(t30, 1000.0000000000000, 1000.0000000000000);
    xsi_vlogfile_write(0, 0, 0, ng4, 2, t0, (char)118, t30, 64);
    t3 = (t0 + 1184U);
    t4 = *((char **)t3);
    t3 = (t0 + 1904);
    t5 = (t3 + 56U);
    t7 = *((char **)t5);
    xsi_vlogfile_write(1, 0, 0, ng18, 3, t0, (char)118, t4, 32, (char)118, t7, 32);
    goto LAB19;

LAB22:    xsi_set_current_line(28, ng0);
    t24 = ((char*)((ng7)));
    t31 = (t0 + 1904);
    xsi_vlogvar_assign_value(t31, t24, 0, 0, 32);
    goto LAB40;

LAB24:    xsi_set_current_line(29, ng0);
    t3 = ((char*)((ng1)));
    t4 = (t0 + 1904);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 32);
    goto LAB40;

LAB26:    xsi_set_current_line(30, ng0);
    t3 = ((char*)((ng1)));
    t4 = (t0 + 1904);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 32);
    goto LAB40;

LAB28:    xsi_set_current_line(31, ng0);
    t3 = ((char*)((ng11)));
    t4 = (t0 + 1904);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 32);
    goto LAB40;

LAB30:    xsi_set_current_line(32, ng0);
    t3 = ((char*)((ng1)));
    t4 = (t0 + 1904);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 32);
    goto LAB40;

LAB32:    xsi_set_current_line(33, ng0);
    t3 = ((char*)((ng1)));
    t4 = (t0 + 1904);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 32);
    goto LAB40;

LAB34:    xsi_set_current_line(34, ng0);
    t3 = ((char*)((ng1)));
    t4 = (t0 + 1904);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 32);
    goto LAB40;

LAB36:    xsi_set_current_line(35, ng0);
    t3 = ((char*)((ng16)));
    t4 = (t0 + 1904);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 32);
    goto LAB40;

}


extern void work_m_00000000000153284084_1409595209_init()
{
	static char *pe[] = {(void *)Cont_17_0,(void *)Cont_19_1,(void *)Always_21_2};
	xsi_register_didat("work_m_00000000000153284084_1409595209", "isim/simulation_isim_beh.exe.sim/work/m_00000000000153284084_1409595209.didat");
	xsi_register_executes(pe);
}
