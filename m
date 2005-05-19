From: rutger@nospam.com (rutger@nospam.com)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: linux 2.6.6 & w83627hf module & Q-Fan
Message-Id: <20040516101015.GA19126@nospam.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I've got a question about the w83627thf sensors which can be found on
a Asus p4p800 motherboard. The comment of the driver (w83627hf.c)
indicates:

    Note: automatic ("cruise") fan control for 697, 637 & 627thf not
    supported yet.

This is called 'Q-Fan' by Asus. How can I support this? Is this not
implemented because of lack of hardware, lack of time or lack of
knowledge?

The problem is I want to be able to read the CPU temperature without
disabling Q-Fan. When I insmod the module now, the fan speeds up to
maximum speed without reason.

Regards,
Rutger.

-- 
Rutger Nijlunsing ---------------------------- rutger ed tux tmfweb nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
