From: davej@redhat.com (Dave Jones)
Date: Tue, 20 Feb 2007 19:11:42 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <20070220191142.GE16614@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com> <45D6DDCE.5050803@assembler.cz> <45D7461A.2040808@redhat.com> <45D8D6AE.3000204@assembler.cz> <45DB0EEA.2010205@redhat.com>
In-Reply-To: <45DB0EEA.2010205@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Rudolf Marek <r.marek@assembler.cz>, linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org

On Tue, Feb 20, 2007 at 10:08:26AM -0500, Chuck Ebbert wrote:
 
 > 	i2c_core
 > 	i2c_ec
 > 	i2c_piix4
 > 	asus_acpi (on a Compaq???)
 > 	sbs

Something is pulling in asus_acpi as a dependancy. I've never
figured out what the cause is.  For a long time I was thinking
that we had an explicit modprobe for it in an initscript, but
grepping for it in /etc turns up zip.

		Dave

-- 
http://www.codemonkey.org.uk

