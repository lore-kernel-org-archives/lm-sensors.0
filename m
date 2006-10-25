From: timm@fnal.gov (Steven Timm)
Date: Wed, 25 Oct 2006 17:36:24 +0000
Subject: [lm-sensors] grafting lm-sensors 2.10.1 onto red hat kernel
Message-Id: <Pine.LNX.4.64.0610251233350.7544@snowball.fnal.gov>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0610251056560.7544@snowball.fnal.gov>
In-Reply-To: <Pine.LNX.4.64.0610251056560.7544@snowball.fnal.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 25 Oct 2006, Jean Delvare wrote:

> Hi Steven,
>
> On Wed, 25 Oct 2006 10:59:20 -0500 (CDT), Steven Timm wrote:
>>
>> Has anyone successfully managed to compile i2c 2.10.1 and lm_sensors
>> 2.10.1 so that they work with kernels such as "2.6.9-42.0.2.ELsmp" as
>> distributed with Red Hat Enterprise Linux 4?
>>
>> For some of the 2.9 version of lm_sensors there used to be
>> lm_sensors-kmdl and i2c-kmdl rpms available in the ATRPMS repository
>> but now I do not see those anymore.  any hints are welcome.
>
> For 2.6 kernels, you don't need the separate module packages,
> everything's already in the kernel tree. All you need is the user-space
> part of lm_sensors, which is available from ATrpms:
> http://atrpms.net/dist/el4/lm_sensors/
>

The kernel as distributed by Red Hat in RHEL4 update 4
(2.6.9-42.0.3) has got
an lm_sensors and i2c in there already but it is a very old version, 
2.8.7.  That is not new enough to support certain chips on new hardware,
particularly the w83792 sensor.  Has anyone successfully
been able to patch the latest 2.10.1 lm_sensors against that
old kernel, and if so, how?


Steve Timm



>

-- 
------------------------------------------------------------------
Steven C. Timm, Ph.D  (630) 840-8525  timm at fnal.gov  http://home.fnal.gov/~timm/
Fermilab Computing Div/Core Support Services Dept./Scientific Computing Section
Assistant Group Leader, Farms and Clustered Systems Group
Lead of Computing Farms Team

