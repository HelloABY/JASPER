#!/usr/bin/env python3
"""
------------------------------------------------------------------------------
SCRIPT:      secure_log_parser.py
DIRECTORY:   JASPER/Tools/automation/
DESCRIPTION: Cross-platform Python log analysis engine. Parses system logs to 
             isolate, aggregate, and report brute-force authentication failures.
------------------------------------------------------------------------------
"""

import os
import sys
import re
from datetime import datetime

# Enforce a strict mock target path for local platform demonstration
MOCK_LOG_DATA = [
    "Oct 08 18:21:05 server1 sshd[1204]: Failed password for root from 192.168.1.45 port 54322 ssh2",
    "Oct 08 18:22:12 server1 sshd[1204]: Failed password for root from 192.168.1.45 port 54328 ssh2",
    "Oct 08 18:23:45 server1 sshd[1312]: Accepted publickey for admin from 10.0.0.15 port 43210 ssh2",
    "Oct 08 18:25:01 server1 sshd[1415]: Failed password for invalid user ubuntu from 203.0.113.5 port 39211 ssh2",
    "Oct 08 18:25:10 server1 sshd[1415]: Failed password for invalid user ubuntu from 203.0.113.5 port 39215 ssh2"
]

class LogParserEngine:
    def __init__(self):
        # Regex signature targeting standard SSH authentication failures
        self.fail_pattern = re.compile(r"Failed password for (?:invalid user )?(\S+) from (\S+)")
        self.audit_summary = {}

    def process_log_stream(self, log_lines):
        """Iterates over log streams and extracts offending vectors."""
        print("[*] Launching stream scanning sequence...")
        for line in log_lines:
            match = self.fail_pattern.search(line)
            if match:
                username = match.group(1)
                ip_address = match.group(2)
                
                # Structural aggregation
                if ip_address not in self.audit_summary:
                    self.audit_summary[ip_address] = {"total_attempts": 0, "target_users": set()}
                
                self.audit_summary[ip_address]["total_attempts"] += 1
                self.audit_summary[ip_address]["target_users"].add(username)

    def generate_markdown_report(self):
        """Compiles parsed metric arrays into an executive Markdown layout."""
        print("\n======================================================================")
        print("📊 J.A.S.P.E.R. AUTOMATION SECURITY REPORT — SECURITY AUDIT")
        print("======================================================================\n")
        
        if not self.audit_summary:
            print("[SUCCESS] Zero authentication anomalies discovered in the current stream.")
            return

        print(f"Report Generated On: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        print("----------------------------------------------------------------------")
        print(f"| {'Offending Source IP':<18} | {'Total Attempts':<14} | {'Targeted Usernames':<22} |")
        print("----------------------------------------------------------------------")
        
        for ip, stats in self.audit_summary.items():
            users = ", ".join(stats["target_users"])
            print(f"| {ip:<18} | {stats['total_attempts']:<14} | {users:<22} |")
        print("----------------------------------------------------------------------")

def main():
    print("[*] Initializing Cross-Platform Event Parsing Engine...")
    engine = LogParserEngine()
    
    # Run the processing loop against the built-in system verification dataset
    engine.process_log_stream(MOCK_LOG_DATA)
    engine.generate_markdown_report()
    print("\n[+] Event parser logging audit concluded cleanly.")

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n[!] Execution terminated by administrative signal.")
        sys.exit(0)
