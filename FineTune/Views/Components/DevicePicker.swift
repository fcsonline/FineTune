// FineTune/Views/Components/DevicePicker.swift
import SwiftUI

/// A styled device picker dropdown using native Menu
struct DevicePicker: View {
    let devices: [AudioDevice]
    let selectedDeviceUID: String
    let onDeviceSelected: (String) -> Void

    @State private var isHovered = false

    private var selectedDevice: AudioDevice? {
        devices.first { $0.uid == selectedDeviceUID }
    }

    private var pickerLabel: some View {
        ZStack {
            // Invisible sizing layer
            Color.clear
                .frame(
                    width: DesignTokens.Dimensions.pickerWidth,
                    height: 20
                )

            // Content layer
            HStack {
                HStack(spacing: DesignTokens.Spacing.xs) {
                    if let icon = selectedDevice?.icon {
                        Image(nsImage: icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                    } else {
                        Image(systemName: "speaker.wave.2")
                            .font(.system(size: 14))
                    }

                    Text(selectedDevice?.name ?? "Select")
                        .font(DesignTokens.Typography.pickerText)
                        .lineLimit(1)
                }

                Spacer(minLength: DesignTokens.Spacing.sm)

                Image(systemName: "chevron.up.chevron.down")
                    .font(.system(size: 8, weight: .medium))
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, DesignTokens.Spacing.sm)
        }
        .contentShape(Rectangle())
    }

    var body: some View {
        Menu {
            ForEach(devices) { device in
                Button {
                    onDeviceSelected(device.uid)
                } label: {
                    HStack {
                        if let icon = device.icon {
                            Image(nsImage: icon)
                        } else {
                            Image(systemName: "speaker.wave.2")
                        }
                        Text(device.name)
                    }
                }
            }
        } label: {
            pickerLabel
        }
        .menuStyle(.button)
        .buttonStyle(.plain)
        .background(
            RoundedRectangle(cornerRadius: DesignTokens.Dimensions.buttonRadius)
                .fill(isHovered ? Color(red: 0.26, green: 0.27, blue: 0.29) : Color(red: 0.212, green: 0.224, blue: 0.235))  // #36393C
        )
        .overlay(
            RoundedRectangle(cornerRadius: DesignTokens.Dimensions.buttonRadius)
                .stroke(Color.white.opacity(0.10), lineWidth: 0.5)
        )
        .onHover { isHovered = $0 }
        .animation(DesignTokens.Animation.hover, value: isHovered)
    }
}

// MARK: - Previews

#Preview("Device Picker") {
    ComponentPreviewContainer {
        VStack(spacing: DesignTokens.Spacing.md) {
            DevicePicker(
                devices: MockData.sampleDevices,
                selectedDeviceUID: MockData.sampleDevices[0].uid,
                onDeviceSelected: { _ in }
            )

            DevicePicker(
                devices: MockData.sampleDevices,
                selectedDeviceUID: MockData.sampleDevices[1].uid,
                onDeviceSelected: { _ in }
            )
        }
    }
}
