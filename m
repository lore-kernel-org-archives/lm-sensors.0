From: mrenzmann@otaku42.de (Michael Renzmann)
Date: Tue, 13 Dec 2005 08:41:57 +0000
Subject: [lm-sensors] Backport of lm77.c for 2.4.x
Message-Id: <1134463317.4459.36.camel@gimli>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all.

I'm currently working on a backport of Andras Bali's lm77.c (as found in
current 2.6.x kernels) to kernel series 2.4.x. The driver is basically
working on my local test platform (PC Engines WRAP2). Now the
fine-tuning has to be done, which brings up several questions.

1.
I'd like to hear some suggestions on what proc files the driver should
create, apart from the usual "temp". This might be necessary as Jean
pointed out in IRC yesterday, since the LM77 offers 5 values rather than
just 3:

* Tmin, minimum temperature (if the current temperature goes below this
value, an alarm bit is set)
* Tmax, maximum temperature (if the current temperature goes above this
value, an alarm bit is set)
* Tcrit, critical temperature (if the current temperature reaches or
goes above this limit, the LM77 will reset the system until temperature
reaches Tcrit - Thyst
* T, current temperature
* Thyst, hysteresis

There is just one hysteresis value that is used wit Tmin, Tmax and
Tcrit.

Currently I think of putting Tmin, Tmax and T into the "temp" proc file,
and:
a. Tcrit and Thyst into two distinct files, or
b. Tcrit and Thyst into one file.

Suggestions?


2.
I'd like to allow the user to enable the "fault queue" feature that the
LM77 provides. Quoting the data sheet:

"A fault queue of up to 4 faults is provided to prevent false
tripping when the LM77 is used in noisy environments. The 4
faults must occur consecutively to set flags as well as INT
and T_CRIT_A outputs."

I'll add a module parameter that allows the user to enable the fault
queue upon initialization. But I think it might be useful to also add a
proc file that allows to enable/disable the fault queue at a later
point, without the need of reloading the module.

Objections? Any suggestion regarding the name for the corresponding proc
file?


3.
The LM77 offers a shutdown mode which reduces power consumption. Is
there any support in the lm_sensors package for suspend/resume (ACPI)? I
think it would make sense to enable the shutdown mode upon suspend and
disable it upon resume.

Bye, Mike


