From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: PATCH RFC fix adm1025 vid reporting
Message-Id: <9bmq31h1mmvapd5eggj6b0q11cp811s4n2@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <6a3o319k8q774n0dgmj2q98u18rum7t2hs@4ax.com>
In-Reply-To: <6a3o319k8q774n0dgmj2q98u18rum7t2hs@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 19 Mar 2005 13:15:06 +0100, Jean Delvare <khali@linux-fr.org> wrote:

>> This trivial patch changes vid reporting for adm1025 to the 
>> standard cpu0_vid filename.  It leaves the older in1_ref file 
>> in, marked as deprecated for later removal so we do not pull 
>> the rug out from anybody.
>
>I like it much. Especially keeping the old file in place is very smart.
>
>> My query is do we need to give notification of feature change 
>> or removal as some other kernel sections are doing?  Trying to 
>> tread very gently...
>
>I don't think we have to. Here you are simply fixing an interface which
>was not following the standard. You are not changing a standard.
>
>> Compile tested, patch tested, but no run test :(  
>
>The patch is quite simple, looks all OK to me.
>
>Could you please provide a patch to libsensors, such that cpu0_vid will
>be accessed instead of in1_ref for the adm1025/ne1619 chips? We might
>not apply it immediately so as to not break compatibility, but at least
>let's have it ready.
>
Is this what you after?  Against latest CVS lm_sensors2, let me know if 
CVS wrong source, please.

Cheers.
Grant.

--- lm_sensors2/lib/chips.c	2005-03-16 09:16:05.000000000 +1100
+++ lm_sensors2x/lib/chips.c	2005-03-20 22:06:02.000000000 +1100
@@ -1939,7 +1939,7 @@
                          ADM9240_SYSCTL_TEMP, VALUE(1), 1, "temp1_max", 3 },
 
     { SENSORS_ADM9240_VID, "vid", NOMAP, NOMAP,
-                         R, ADM9240_SYSCTL_VID, VALUE(1), 2, "in1_ref", 3 },
+                         R, ADM9240_SYSCTL_VID, VALUE(1), 2, "cpu0_vid", 3 },
     { SENSORS_ADM9240_FAN1_DIV, "fan1_div", SENSORS_ADM9240_FAN1, 
                          NOMAP, RW, 
                          ADM9240_SYSCTL_FAN_DIV, VALUE(1), 0 },
@@ -2588,7 +2588,7 @@
                          SENSORS_ADM1025_TEMP2, RW, 
                          ADM1025_SYSCTL_TEMP, VALUE(1), 1 },
     { SENSORS_ADM1025_VID, "vid", NOMAP, NOMAP,
-                         R, ADM1025_SYSCTL_VID, VALUE(1), 3 , "in1_ref", 3 },
+                         R, ADM1025_SYSCTL_VID, VALUE(1), 3 , "cpu0_vid", 3 },
     { SENSORS_ADM1025_VRM, "vrm", NOMAP, NOMAP,
                          RW, ADM1025_SYSCTL_VRM, VALUE(1), 1 },
     { SENSORS_ADM1025_ALARMS, "alarms", NOMAP, NOMAP, 
