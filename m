From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 25 Oct 2006 17:26:01 +0000
Subject: [lm-sensors] grafting lm-sensors 2.10.1 onto red hat kernel
Message-Id: <20061025192601.34d0d036.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0610251056560.7544@snowball.fnal.gov>
In-Reply-To: <Pine.LNX.4.64.0610251056560.7544@snowball.fnal.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Steven,

On Wed, 25 Oct 2006 10:59:20 -0500 (CDT), Steven Timm wrote:
> 
> Has anyone successfully managed to compile i2c 2.10.1 and lm_sensors 
> 2.10.1 so that they work with kernels such as "2.6.9-42.0.2.ELsmp" as
> distributed with Red Hat Enterprise Linux 4?
>
> For some of the 2.9 version of lm_sensors there used to be
> lm_sensors-kmdl and i2c-kmdl rpms available in the ATRPMS repository
> but now I do not see those anymore.  any hints are welcome.

For 2.6 kernels, you don't need the separate module packages,
everything's already in the kernel tree. All you need is the user-space
part of lm_sensors, which is available from ATrpms:
http://atrpms.net/dist/el4/lm_sensors/

-- 
Jean Delvare

