From: bon@elektron.ikp.physik.tu-darmstadt.de (Uwe Bonnes)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: Expose the switches on w83781d
Message-Id: <16311.44445.787036.582416@hertz.ikp.physik.tu-darmstadt.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo,

appended patch exposes the switches of the w83781d. 

On my Gigabyte BXD board, the fans of the two CPUs are connected to these
switches. With the simple "fanctrl.c" as example, I monitor system activity
and switch off the fans if most time is taken by the idle process.

Bye 

-- 
Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 162516 -------- Fax. 06151 164321 ----------
--- /tmp/w83781d.c	2003-11-16 17:50:11.000000000 +0100
+++ linux/drivers/sensors/w83781d.c	2003-11-15 19:58:40.000000000 +0100
@@ -391,6 +391,7 @@
 	u8 rt[3][32];		/* Register value */
 #endif
 	u8 vrm;
+        u8 sw;
 };
 
 
@@ -432,6 +433,8 @@
 static void w83781d_rt(struct i2c_client *client, int operation,
 		       int ctl_name, int *nrels_mag, long *results);
 #endif
+static void w83781d_sw(struct i2c_client *client, int operation,
+                        int ctl_name, int *nrels_mag, long *results);
 static u16 swap_bytes(u16 val);
 
 static int w83781d_id = 0;
@@ -473,6 +476,7 @@
 #define W83781D_SYSCTL_PWM2 1402
 #define W83781D_SYSCTL_PWM3 1403
 #define W83781D_SYSCTL_PWM4 1404
+#define W83781D_SYSCTL_SW   1405
 #define W83781D_SYSCTL_SENS1 1501	/* 1, 2, or Beta (3000-5000) */
 #define W83781D_SYSCTL_SENS2 1502
 #define W83781D_SYSCTL_SENS3 1503
@@ -599,6 +603,8 @@
 	{W83781D_SYSCTL_RT3, "rt3", NULL, 0, 0644, NULL, &i2c_proc_real,
 	 &i2c_sysctl_real, NULL, &w83781d_rt},
 #endif
+        {W83781D_SYSCTL_SW, "sw", NULL, 0, 0644, NULL, &i2c_proc_real,
+        &i2c_sysctl_real, NULL, &w83781d_sw},
 	{0}
 };
 
@@ -1747,6 +1753,7 @@
                data->beep_enable = i >> 7;
                data->beeps = ((i & 0x7f) << 8) +
                    w83781d_read_value(client, W83781D_REG_BEEP_INTS1);
+               data->sw = w83781d_read_value(client, W83781D_REG_BEEP_CONFIG) & 0x3f;
                if ((data->type != w83781d) && (data->type != as99127f)
                    && (data->type != w83791d)) {
                        data->beeps |@@ -2108,6 +2115,26 @@
 	}
 }
 
+void w83781d_sw(struct i2c_client *client, int operation, int ctl_name,
+                int *nrels_mag, long *results)
+{
+       struct w83781d_data *data = client->data;
+
+       if (operation = SENSORS_PROC_REAL_INFO)
+               *nrels_mag = 0;
+       else if (operation = SENSORS_PROC_REAL_READ) {
+               w83781d_update_client(client);
+               results[0] = data->sw;
+               *nrels_mag = 1;
+       } else if (operation = SENSORS_PROC_REAL_WRITE) {
+               if (*nrels_mag >= 1) {
+                       data->sw = results[0] & 0x3f;
+                       w83781d_write_value(client, W83781D_REG_BEEP_CONFIG,
+                                           data->sw);
+               }
+        }
+}
+
 void w83781d_sens(struct i2c_client *client, int operation, int ctl_name,
 		  int *nrels_mag, long *results)
 {
==sampe usage for the sw: fanctrl.c==#include <unistd.h>
#include <stdio.h>

#define DO_RUN "echo 21 >/proc/sys/dev/sensors/w83781d-isa-0290/sw"
#define DO_STOP "echo 5 >/proc/sys/dev/sensors/w83781d-isa-0290/sw"
int main(int argc, char** argv)
{

  int fanrun=1;
  unsigned int index=0;
  FILE *uptime;
  char buffer[256];
  unsigned int total[6],idle[6];
  unsigned int value1,value2,value3,value4;

  uptime = fopen("/proc/uptime", "r" );
  if (!uptime) {
    fprintf(stderr,"can't get /proc/uptime entry\n");
    return 1;
  }
  if (!fgets( buffer, sizeof(buffer), uptime )) {
    fprintf(stderr,"can't get anything out of /proc/uptime\n");
    return 2;
  }
  if (sscanf( buffer,"%d.%d %d.%d",&value1,&value2,&value3,&value4)!=4) {
    fprintf(stderr,"can't get desired entries\n");
    return 3;
  }
  total[0]=total[1]=total[2]=total[3]=total[4]=total[5]=value1*100+value2;
  idle[0]=idle[1]=idle[2]=idle[3]=idle[4]=idle[5]=value3*100+value4;
  index++;
  fclose(uptime);
  daemon (0,0);

  while (1) {
    sleep(15);
    uptime = fopen("/proc/uptime", "r" );
    fgets( buffer, sizeof(buffer), uptime );
    fclose(uptime);
    sscanf( buffer,"%d.%d %d.%d",&value1,&value2,&value3,&value4);
    total[index%6]=value1*100+value2;
    idle[index%6]=value3*100+value4;
#if 0
    fprintf(stdout, "index %d index1 %d\n",index%6,(index-1)%6);
    fprintf(stdout, "idle[%d] %d total[%d] %d\n", index%6,idle[index%6],index%6,total[index%6]);
    fprintf(stdout, "idle[%d] %d total[%d] %d\n", (index-1)%6,idle[(index-1)%6],(index-1)%6,total[(index-1)%6]);
    
    fprintf(stdout,"idle %d total %d\n\n",idle[index%6]-idle[(index-1)%6],total[index%6]-total[(index-1)%6]);
#endif
#if 0
    if ( (((idle[index%6]-idle[(index-1)%6])*1000)/(total[index%6]-total[(index-1)%6]))> 600) 
      fprintf(stdout,"short term idle  ");
    else
      fprintf(stdout,"short term active");
	  fprintf(stdout," %3d %3d",(((idle[index%6]-idle[(index-1)%6])*1000)/(total[index%6]-total[(index-1)%6])),(((idle[index%6]-idle[(index-5)%6])*1000)/(total[index%6]-total[(index-5)%6])));
    if ( (((idle[index%6]-idle[(index-5)%6])*1000)/(total[index%6]-total[(index-5)%6]))> 750) 
      fprintf(stdout,"  long term idle  \n");
    else
      fprintf(stdout,"  long term active\n");
#endif
    if ( ((((idle[index%6]-idle[(index-1)%6])*1000)/(total[index%6]-total[(index-1)%6]))< 550)
	 ||((((idle[index%6]-idle[(index-5)%6])*1000)/(total[index%6]-total[(index-5)%6]))< 800)) {
      if (!fanrun) {
	fprintf(stdout, "switch ON\n");
	system(DO_RUN);
	fanrun=1;
      }
    }
    else 
      if(fanrun) {
	fprintf(stdout, "switch OFF \n");
	system(DO_STOP);
	fanrun=0;
      }
    index++;
  }
  return 0;
}


