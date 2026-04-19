#!/usr/bin/env node

const fs = require('fs');

const cmd = process.argv[2];
const file = process.argv[3];
const wo = process.argv[4];

if (!cmd || !file) {
    console.error("Usage: shift-manager.js <init|add|complete|list-pending> <schedule-file> [work-order]");
    process.exit(1);
}

try {
    if (cmd === 'init') {
        fs.writeFileSync(file, JSON.stringify({ shifts: [] }, null, 2));
    } else if (cmd === 'add') {
        if (!wo) throw new Error("Work order required for 'add' command");
        const data = JSON.parse(fs.readFileSync(file, 'utf8'));
        if (!data.shifts.find(s => s.work_order === wo)) {
            data.shifts.push({ work_order: wo, status: 'pending' });
            fs.writeFileSync(file, JSON.stringify(data, null, 2));
            console.log(`Added ${wo} to schedule.`);
        } else {
            console.log(`${wo} is already in the schedule.`);
        }
    } else if (cmd === 'complete') {
        if (!wo) throw new Error("Work order required for 'complete' command");
        const data = JSON.parse(fs.readFileSync(file, 'utf8'));
        const shift = data.shifts.find(s => s.work_order === wo);
        if (shift) {
            shift.status = 'completed';
            fs.writeFileSync(file, JSON.stringify(data, null, 2));
            console.log(`Marked ${wo} as completed.`);
        }
    } else if (cmd === 'list-pending') {
        const data = JSON.parse(fs.readFileSync(file, 'utf8'));
        const pending = data.shifts.filter(s => s.status === 'pending').map(s => s.work_order);
        if (pending.length > 0) {
            console.log(pending.join(' '));
        }
    } else {
        console.error("Unknown command:", cmd);
        process.exit(1);
    }
} catch (e) {
    console.error(`Error processing ${cmd}:`, e.message);
    process.exit(1);
}
