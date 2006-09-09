From: bob2@dsv.nl (Bob =?ISO-8859-1?Q?Schl=E4rmann?=)
Date: Sat, 09 Sep 2006 15:13:36 +0000
Subject: [lm-sensors] generic chip support in libsensors
Message-Id: <20060909171336.419b7b80@ws01.atreidis.nl.eu.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44C78622.8060808@hhs.nl>
In-Reply-To: <44C78622.8060808@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

Hans de Goede recently mentioned that he would put up a student project
to let them work on some of the steps needed for generic chip support.
I'm a student of Hans and together with 2 others we have taken on this
project. All of us have experience in programming with Linux and
we think we understand the problems libsensors is currently facing with
adding support for new chipsets. We also realise that any code we
release will be subject to the gpl.

We would first like to focus on steps 1 (use sysfs to discover a chip's
features) and 3 (generic print routines in 'sensors'). The following are
summaries of the objectives as we formulated them:

for step 1: modify the library so that it wil not be necessery anymore
to add seperate support code into the library for newly supported chips.

step 3: modify the sensors tool print routines to add support for types
of sensors instead of the current support for types of chips.

Our plan was to first begin with step 1 and release code for it as soon
as possible, as to get an idea of how the cycle of releasing and
testing goes. Later on we will begin with step 3.

One question we have is whether it is a good idea to work on step 3
without dealing with step 2 (add sensor type info to structure) first.
Because once step 2 is implemented, step 3 seems easier to accomplish.

--
Bob Schl?rmann, project leader


