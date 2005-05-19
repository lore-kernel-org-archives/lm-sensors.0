From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: Support of i2c-nscacb
Message-Id: <427B7968.9070701@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4263B107.1070703@buholzer.com>
In-Reply-To: <4263B107.1070703@buholzer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>
> 
> * Add a call to the procedure in prog/sensors/main.c (for chip drivers only).
>   Put it at the bottom of do_a_print().
> 

make that 'add the procedure to the matches[] table in prog/sensors/main.c'.
I'll update our docs.
