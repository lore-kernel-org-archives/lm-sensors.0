From: david.c.hubbard@gmail.com (David Hubbard)
Date: Fri, 01 Sep 2006 18:20:28 +0000
Subject: [lm-sensors] [RFC PATCH 2.6.18-rc4-mm1] hwmon: unchecked return
Message-Id: <4dfa50520609011120h3052db5fmf76c7a8f9820a6fe@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060814020407.GA3327@jupiter.solarsys.private>
In-Reply-To: <20060814020407.GA3327@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> Back to the mailing-list, as I doubt you replied to me privately on
> purpose?

Oops, yes, I forgot.

> Applied, with two minor edits:
>
> * Moved the "Register sysfs hooks" comment back to where it belongs.
> * In w83627ehf_detach_client, call hwmon_device_unregister before
> w83627ehf_device_remove_files. It probably doesn't matter much as
> everything ends up being removed, but it looks less confusing for
> userspace that way.

Okay, that's good.

David

