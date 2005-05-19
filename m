From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: RFC adding special interfaces to sysfs?
Message-Id: <7e4g31d06hpvo09p853tatqrsd924mi51v@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <g0l431lg0hrj7msln8smiiah4566i21nhd@4ax.com>
In-Reply-To: <g0l431lg0hrj7msln8smiiah4566i21nhd@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,

On Wed, 16 Mar 2005 11:03:04 +0100, you wrote:

>> As far as Chassis Intrusion (CI) goes, I've coerced an unused IN 
>> limit for time being as all I need is a write-only trigger event. 
>
>This is no good. We made the interface such that user-space can guess
>what any chip does and how to access it without any chip-specific
>knowledge. If you implement chassis intrusion, please make it a separate
>file with a dedicated, explicit name.

Okay, current plan is to add the chassis_clear sysfs option, 
implementation unlikely as pointed out by Mark but documented 
in case we go there.

Still need analog output -- two candidates in use plus pwm0 
option, just a choice of which way to go, decision can wait 
for agreement.  

Cheers,
Grant.
