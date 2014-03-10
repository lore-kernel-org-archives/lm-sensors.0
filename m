From: "George Spelvin" <linux@horizon.com>
Date: Mon, 10 Mar 2014 07:11:40 +0000
Subject: Re: [lm-sensors] Tachometer speed returned rather than absolute fan speed?
Message-Id: <20140310071140.19969.qmail@ns.horizon.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20140307162524.6abd34be@endymion.delvare>
References: <CAOMwXhPXPN+21N11cHBENvw0QZ1qPvo9GTbM9V2SwDmgBQZssw@mail.gmail.com>
In-Reply-To: <CAOMwXhPXPN+21N11cHBENvw0QZ1qPvo9GTbM9V2SwDmgBQZssw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jdelvare@suse.com
Cc: linux@horizon.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, lpapp@kde.org

> What did you think "tachometer speed" was, if not the fan speed? Does
> the max6650 driver not return correct fan speeds for you?

Given that most PC fans produce two pulses per rotation, I assumed it was
the frequency of the tachometer signal, which is twice the fan RPM.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
