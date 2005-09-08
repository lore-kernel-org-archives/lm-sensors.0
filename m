From: rhirst@levanta.com (Richard Hirst)
Date: Thu, 08 Sep 2005 20:51:30 +0000
Subject: [lm-sensors] i801_smbus 0000:00:1f.3: Bus collision!
Message-Id: <20050908185048.GM8392@levanta.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050907213603.GW8392@levanta.com>
In-Reply-To: <20050907213603.GW8392@levanta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Sep 08, 2005 at 01:12:34PM -0400, Mark M. Hoffman wrote:
> Richard's symptoms seem to implicate the i2c-i801 and i2c-core patches.

Yeah, got a stack trace at the point where it starts recursing
down the stack:

Call Trace:
 [<f89e4bb7>] i801_start+0x2fd/0x375 [i2c_i801]
 [<f8a0ede6>] i2c_start_entry+0x28/0x52 [i2c_core]
 [<f8a1010c>] i2c_non_blocking_op+0xbb/0xcf [i2c_core]
 [<f8ea5960>] start_resend+0x7d/0x99 [ipmi_smb]
 [<f8ea52d9>] msg_done_handler+0x57/0x532 [ipmi_smb]
 [<c011e09c>] printk+0xe/0x11
 [<f89e4680>] i801_block_next_byte+0xb7/0xfd [i2c_i801]
 [<f8a0eec0>] i2c_entry_put+0x58/0x7c [i2c_core]
 [<f89e4c1e>] i801_start+0x364/0x375 [i2c_i801]
 [<f8a0ede6>] i2c_start_entry+0x28/0x52 [i2c_core]
 [<f8a1010c>] i2c_non_blocking_op+0xbb/0xcf [i2c_core]
 [<f8ea525a>] retry_timeout+0x47/0x6f [ipmi_smb]
 [<f8ea5213>] retry_timeout+0x0/0x6f [ipmi_smb]
 [<c012548a>] run_timer_softirq+0x123/0x145
 [<c0122094>] __do_softirq+0x4c/0xb1
 [<c0105db7>] do_softirq+0x41/0x48


so it looks like there is now a path where a request can fail
in i2c_start() which causes it to start the next request
which calls i2c_start() ... etc.

Pretty clear this is most likely an issue with the patches I'm
using.  Thanks to you both for the helpful responses.

Richard

