From: wim@iguana.be (Wim Van Sebroeck)
Date: Mon, 05 Feb 2007 22:08:38 +0000
Subject: [lm-sensors] ACPI bytecode hardware registers access
Message-Id: <20070205220838.GB2509@infomag.infomag.iguana.be>
List-Id: <lm-sensors.vger.kernel.org>
References: <45C640CF.2090205@assembler.cz> <3877989d0702050003w3e0be4d3q9c475d2c6706f6a8@mail.gmail.com> <45C74337.4060105@assembler.cz> <45C7506A.20402@linux.intel.com> <45C75E20.8010101@assembler.cz>
In-Reply-To: <45C75E20.8010101@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rudolf Marek <r.marek@assembler.cz>
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, LM Sensors <lm-sensors@lm-sensors.org>, linux-acpi@vger.kernel.org

Hi Rudolf,

My feeling: I/O-devices that provide different functions via the
same register-set, should have a core that takes care of the 
communication with the I/O-device. (like for instance the w83627hf
chipset that has sensor functionailty but also watchdog capabilities).
The core needs to make sure that all different drivers can function
without interfering with each other (via proper locking mechanism's
off-course).

You could get something like this:
w83627hf_core
w83627hf_sensors -> depends on w83627hf_core
w83627hf_watchdog -> depends also on w83627hf_core

Don't know if this is a solution for the acpi problem also.

Greetings,
Wim.


