import SwiftUI

struct WorkshopDetailView: View {
    
    @State private var showBooking = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            headerImage
            workshopDetails
            Spacer()
            bookingButton
        }
        .padding(.top)
        .navigationDestination(isPresented: $showBooking) {
            BookingView()
        }
    }

    // MARK: - Header Image Section
    private var headerImage: some View {
        ZStack(alignment: .topLeading) {
            Image(AppStrings.Images.workshopSample)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 400)
                .cornerRadius(12)
                .clipped()
            
            VStack(alignment: .leading, spacing: 6) {
                featuredBadge
                popularityBadge
            }
            .padding(8)
            
            HStack {
                Spacer()
                VStack {
                    Image(systemName: AppStrings.Images.heartIcon)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .clipShape(Circle())
                        .padding()
                }
            }
        }
    }

    // MARK: - Workshop Info Section
    private var workshopDetails: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(AppStrings.WorkshopDetailView.category)
                .font(.caption)
                .foregroundColor(.orange)
            
            Text(AppStrings.WorkshopDetailView.title)
                .font(.headline)
                .foregroundColor(.primary)
            
            HStack(spacing: 4) {
                Image(systemName: AppStrings.Images.mapPin)
                Text(AppStrings.WorkshopDetailView.location)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            HStack(spacing: 4) {
                Image(systemName: AppStrings.Images.starFill)
                    .foregroundColor(.yellow)
                Text(AppStrings.WorkshopDetailView.rating)
                    .font(.subheadline)
            }
            
            HStack(spacing: 4) {
                Text(AppStrings.WorkshopDetailView.price)
                    .font(.title3)
                    .fontWeight(.bold)
                Text(AppStrings.WorkshopDetailView.perPerson)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            HStack(spacing: 20) {
                Label(AppStrings.WorkshopDetailView.duration, systemImage: AppStrings.Images.clock)
                Label(AppStrings.WorkshopDetailView.maxParticipants, systemImage: AppStrings.Images.people)
            }
            .font(.footnote)
            .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }

    // MARK: - Booking Button
    private var bookingButton: some View {
        Button(action: {
            showBooking = true
        }) {
            Text(AppStrings.WorkshopDetailView.confirmBooking)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(12)
                .font(.headline)
        }
        .padding([.horizontal, .bottom])
    }

    // MARK: - Badges
    private var featuredBadge: some View {
        Text(AppStrings.WorkshopDetailView.featured)
            .font(.caption)
            .fontWeight(.bold)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(8)
    }

    private var popularityBadge: some View {
        Text(AppStrings.WorkshopDetailView.high)
            .font(.caption2)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(6)
    }
}
