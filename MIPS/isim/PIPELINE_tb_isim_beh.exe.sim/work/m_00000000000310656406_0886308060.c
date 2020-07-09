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
static const char *ng0 = "D:/CSE401/Lab6/MIPS/ALU.v";
static unsigned int ng1[] = {2U, 0U};
static unsigned int ng2[] = {6U, 0U};
static unsigned int ng3[] = {0U, 0U};
static unsigned int ng4[] = {1U, 0U};
static unsigned int ng5[] = {7U, 0U};
static int ng6[] = {1, 0};
static int ng7[] = {0, 0};
static unsigned int ng8[] = {3U, 0U};
static unsigned int ng9[] = {4294967295U, 4294967295U};



static void Always_20_0(char *t0)
{
    char t10[8];
    char t40[8];
    char t41[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    int t6;
    char *t7;
    char *t8;
    char *t9;
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
    char *t21;
    char *t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    int t31;
    int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    char *t39;
    char *t42;
    char *t43;
    char *t44;

LAB0:    t1 = (t0 + 2848U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(20, ng0);
    t2 = (t0 + 3168);
    *((int *)t2) = 1;
    t3 = (t0 + 2880);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(21, ng0);

LAB5:    xsi_set_current_line(22, ng0);
    t4 = (t0 + 1368U);
    t5 = *((char **)t4);

LAB6:    t4 = ((char*)((ng1)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 3, t4, 3);
    if (t6 == 1)
        goto LAB7;

LAB8:    t2 = ((char*)((ng2)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 3, t2, 3);
    if (t6 == 1)
        goto LAB9;

LAB10:    t2 = ((char*)((ng3)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 3, t2, 3);
    if (t6 == 1)
        goto LAB11;

LAB12:    t2 = ((char*)((ng4)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 3, t2, 3);
    if (t6 == 1)
        goto LAB13;

LAB14:    t2 = ((char*)((ng5)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 3, t2, 3);
    if (t6 == 1)
        goto LAB15;

LAB16:    t2 = ((char*)((ng8)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 3, t2, 3);
    if (t6 == 1)
        goto LAB17;

LAB18:
LAB19:    xsi_set_current_line(36, ng0);
    t2 = (t0 + 1928);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memset(t40, 0, 8);
    t7 = (t4 + 4);
    t11 = *((unsigned int *)t7);
    t12 = (~(t11));
    t13 = *((unsigned int *)t4);
    t14 = (t13 & t12);
    t15 = (t14 & 4294967295U);
    if (t15 != 0)
        goto LAB44;

LAB45:    if (*((unsigned int *)t7) != 0)
        goto LAB46;

LAB47:    t9 = (t40 + 4);
    t16 = *((unsigned int *)t40);
    t17 = *((unsigned int *)t9);
    t18 = (t16 || t17);
    if (t18 > 0)
        goto LAB48;

LAB49:    t19 = *((unsigned int *)t40);
    t20 = (~(t19));
    t23 = *((unsigned int *)t9);
    t24 = (t20 || t23);
    if (t24 > 0)
        goto LAB50;

LAB51:    if (*((unsigned int *)t9) > 0)
        goto LAB52;

LAB53:    if (*((unsigned int *)t40) > 0)
        goto LAB54;

LAB55:    memcpy(t10, t22, 8);

LAB56:    t39 = (t0 + 1768);
    xsi_vlogvar_wait_assign_value(t39, t10, 0, 0, 1, 0LL);
    goto LAB2;

LAB7:    xsi_set_current_line(24, ng0);
    t7 = (t0 + 1048U);
    t8 = *((char **)t7);
    t7 = (t0 + 1208U);
    t9 = *((char **)t7);
    memset(t10, 0, 8);
    xsi_vlog_unsigned_add(t10, 32, t8, 32, t9, 32);
    t7 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t7, t10, 0, 0, 32, 0LL);
    goto LAB19;

LAB9:    xsi_set_current_line(26, ng0);
    t3 = (t0 + 1048U);
    t4 = *((char **)t3);
    t3 = (t0 + 1208U);
    t7 = *((char **)t3);
    memset(t10, 0, 8);
    xsi_vlog_unsigned_minus(t10, 32, t4, 32, t7, 32);
    t3 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t3, t10, 0, 0, 32, 0LL);
    goto LAB19;

LAB11:    xsi_set_current_line(28, ng0);
    t3 = (t0 + 1048U);
    t4 = *((char **)t3);
    t3 = (t0 + 1208U);
    t7 = *((char **)t3);
    t11 = *((unsigned int *)t4);
    t12 = *((unsigned int *)t7);
    t13 = (t11 & t12);
    *((unsigned int *)t10) = t13;
    t3 = (t4 + 4);
    t8 = (t7 + 4);
    t9 = (t10 + 4);
    t14 = *((unsigned int *)t3);
    t15 = *((unsigned int *)t8);
    t16 = (t14 | t15);
    *((unsigned int *)t9) = t16;
    t17 = *((unsigned int *)t9);
    t18 = (t17 != 0);
    if (t18 == 1)
        goto LAB20;

LAB21:
LAB22:    t39 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t39, t10, 0, 0, 32, 0LL);
    goto LAB19;

LAB13:    xsi_set_current_line(30, ng0);
    t3 = (t0 + 1048U);
    t4 = *((char **)t3);
    t3 = (t0 + 1208U);
    t7 = *((char **)t3);
    t11 = *((unsigned int *)t4);
    t12 = *((unsigned int *)t7);
    t13 = (t11 | t12);
    *((unsigned int *)t10) = t13;
    t3 = (t4 + 4);
    t8 = (t7 + 4);
    t9 = (t10 + 4);
    t14 = *((unsigned int *)t3);
    t15 = *((unsigned int *)t8);
    t16 = (t14 | t15);
    *((unsigned int *)t9) = t16;
    t17 = *((unsigned int *)t9);
    t18 = (t17 != 0);
    if (t18 == 1)
        goto LAB23;

LAB24:
LAB25:    t39 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t39, t10, 0, 0, 32, 0LL);
    goto LAB19;

LAB15:    xsi_set_current_line(32, ng0);
    t3 = (t0 + 1048U);
    t4 = *((char **)t3);
    t3 = (t0 + 1208U);
    t7 = *((char **)t3);
    memset(t41, 0, 8);
    t3 = (t4 + 4);
    if (*((unsigned int *)t3) != 0)
        goto LAB27;

LAB26:    t8 = (t7 + 4);
    if (*((unsigned int *)t8) != 0)
        goto LAB27;

LAB30:    if (*((unsigned int *)t4) < *((unsigned int *)t7))
        goto LAB28;

LAB29:    memset(t40, 0, 8);
    t21 = (t41 + 4);
    t11 = *((unsigned int *)t21);
    t12 = (~(t11));
    t13 = *((unsigned int *)t41);
    t14 = (t13 & t12);
    t15 = (t14 & 1U);
    if (t15 != 0)
        goto LAB31;

LAB32:    if (*((unsigned int *)t21) != 0)
        goto LAB33;

LAB34:    t39 = (t40 + 4);
    t16 = *((unsigned int *)t40);
    t17 = *((unsigned int *)t39);
    t18 = (t16 || t17);
    if (t18 > 0)
        goto LAB35;

LAB36:    t19 = *((unsigned int *)t40);
    t20 = (~(t19));
    t23 = *((unsigned int *)t39);
    t24 = (t20 || t23);
    if (t24 > 0)
        goto LAB37;

LAB38:    if (*((unsigned int *)t39) > 0)
        goto LAB39;

LAB40:    if (*((unsigned int *)t40) > 0)
        goto LAB41;

LAB42:    memcpy(t10, t43, 8);

LAB43:    t44 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t44, t10, 0, 0, 32, 0LL);
    goto LAB19;

LAB17:    xsi_set_current_line(34, ng0);
    t3 = ((char*)((ng9)));
    t4 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t4, t3, 0, 0, 32, 0LL);
    goto LAB19;

LAB20:    t19 = *((unsigned int *)t10);
    t20 = *((unsigned int *)t9);
    *((unsigned int *)t10) = (t19 | t20);
    t21 = (t4 + 4);
    t22 = (t7 + 4);
    t23 = *((unsigned int *)t4);
    t24 = (~(t23));
    t25 = *((unsigned int *)t21);
    t26 = (~(t25));
    t27 = *((unsigned int *)t7);
    t28 = (~(t27));
    t29 = *((unsigned int *)t22);
    t30 = (~(t29));
    t31 = (t24 & t26);
    t32 = (t28 & t30);
    t33 = (~(t31));
    t34 = (~(t32));
    t35 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t35 & t33);
    t36 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t36 & t34);
    t37 = *((unsigned int *)t10);
    *((unsigned int *)t10) = (t37 & t33);
    t38 = *((unsigned int *)t10);
    *((unsigned int *)t10) = (t38 & t34);
    goto LAB22;

LAB23:    t19 = *((unsigned int *)t10);
    t20 = *((unsigned int *)t9);
    *((unsigned int *)t10) = (t19 | t20);
    t21 = (t4 + 4);
    t22 = (t7 + 4);
    t23 = *((unsigned int *)t21);
    t24 = (~(t23));
    t25 = *((unsigned int *)t4);
    t31 = (t25 & t24);
    t26 = *((unsigned int *)t22);
    t27 = (~(t26));
    t28 = *((unsigned int *)t7);
    t32 = (t28 & t27);
    t29 = (~(t31));
    t30 = (~(t32));
    t33 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t33 & t29);
    t34 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t34 & t30);
    goto LAB25;

LAB27:    t9 = (t41 + 4);
    *((unsigned int *)t41) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB29;

LAB28:    *((unsigned int *)t41) = 1;
    goto LAB29;

LAB31:    *((unsigned int *)t40) = 1;
    goto LAB34;

LAB33:    t22 = (t40 + 4);
    *((unsigned int *)t40) = 1;
    *((unsigned int *)t22) = 1;
    goto LAB34;

LAB35:    t42 = ((char*)((ng6)));
    goto LAB36;

LAB37:    t43 = ((char*)((ng7)));
    goto LAB38;

LAB39:    xsi_vlog_unsigned_bit_combine(t10, 32, t42, 32, t43, 32);
    goto LAB43;

LAB41:    memcpy(t10, t42, 8);
    goto LAB43;

LAB44:    *((unsigned int *)t40) = 1;
    goto LAB47;

LAB46:    t8 = (t40 + 4);
    *((unsigned int *)t40) = 1;
    *((unsigned int *)t8) = 1;
    goto LAB47;

LAB48:    t21 = ((char*)((ng7)));
    goto LAB49;

LAB50:    t22 = ((char*)((ng6)));
    goto LAB51;

LAB52:    xsi_vlog_unsigned_bit_combine(t10, 32, t21, 32, t22, 32);
    goto LAB56;

LAB54:    memcpy(t10, t21, 8);
    goto LAB56;

}


extern void work_m_00000000000310656406_0886308060_init()
{
	static char *pe[] = {(void *)Always_20_0};
	xsi_register_didat("work_m_00000000000310656406_0886308060", "isim/PIPELINE_tb_isim_beh.exe.sim/work/m_00000000000310656406_0886308060.didat");
	xsi_register_executes(pe);
}
