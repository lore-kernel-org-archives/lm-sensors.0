From: tandrews@grok.co.za (Thomas Andrews)
Date: Fri, 05 May 2006 13:16:21 +0000
Subject: [lm-sensors] architecture for slave mode
Message-Id: <20060505131621.GK19375@grok.co.za>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I have managed successfully to make the scx200_acb.c module use either
interrupts or use polling, so that I can ultimately operate the adapter
as a slave.

To achieve this, I need a 'task' that sleeps most of the time, and will
get woken up by my ISR. This task can then do one of two things:

    (a) If the adapter is busy as a master, then wake the master
        state-machine to continue with the comms, or
    (b) If the adapter is idle, invoke the slave state-machine to receive
        the data from the bus.

(At the moment the ISR just wakes the master state-machine directly.)

Questions:

    (1) How is it best to create/start this 'receiver task'?
        Should this be done in i2c-core.c ?
    (2) An interpreter proc will have to be called by the slave
        state-machine. Presumably my 'client' driver will install this
        by means of some call-back. Would one use something like
        i2c_register_entry() for that ? 

I don't really understand fully how all the i2c-* modules fit together,
so please feel free to tell me if I'm off the track here..

Regards,
Thomas

