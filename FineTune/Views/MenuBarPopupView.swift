// FineTune/Views/MenuBarPopupView.swift
import SwiftUI

struct MenuBarPopupView: View {
    @Bindable var audioEngine: AudioEngine
    @Bindable var systemVolumeMonitor: SystemVolumeMonitor

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // System volume row
            SystemVolumeRowView(
                deviceName: systemVolumeMonitor.deviceName,
                deviceIcon: systemVolumeMonitor.deviceIcon,
                volume: systemVolumeMonitor.volume,
                onVolumeChange: { volume in
                    systemVolumeMonitor.setVolume(volume)
                }
            )

            Divider()

            if audioEngine.apps.isEmpty {
                HStack {
                    Spacer()
                    VStack(spacing: 8) {
                        Image(systemName: "speaker.slash")
                            .font(.title)
                            .foregroundStyle(.secondary)
                        Text("No apps playing audio")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                }
                .padding(.vertical, 20)
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(audioEngine.apps) { app in
                            AppVolumeRowView(
                                app: app,
                                volume: audioEngine.getVolume(for: app),
                                onVolumeChange: { volume in
                                    audioEngine.setVolume(for: app, to: volume)
                                },
                                devices: audioEngine.outputDevices,
                                selectedDeviceUID: audioEngine.getDeviceUID(for: app),
                                onDeviceSelected: { deviceUID in
                                    audioEngine.setDevice(for: app, deviceUID: deviceUID)
                                }
                            )
                        }
                    }
                }
                .frame(maxHeight: 400)
            }

            Divider()

            Button("Quit FineTune") {
                NSApplication.shared.terminate(nil)
            }
            .buttonStyle(.plain)
            .foregroundStyle(.secondary)
            .font(.caption)
        }
        .padding()
        .frame(width: 450)
    }
}
